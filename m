Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55971780C92
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 15:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377169AbjHRNfD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 09:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377163AbjHRNeb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 09:34:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1983589
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 06:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692365622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qQNTfs2Jffit8DhxI9Sae6fRQlQxO579aHpEAqyIh68=;
        b=UX3cp/NHhBZmIxAhdMghd/vF9KxFf0lrncqhttw2NutOQeNME95LgBiszTjUbkD/PKkxbQ
        Wz0kGxd9lEqRwUDmnHWcvJyfjkR6mTQRiTxguxVPQMhleqKRn2nGkAwYbqDRXgZ5emCzSz
        C202KQoO+kJRVgcI5jiz6t79lJs7gIw=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-352-EJIL4rjEN7KeEtSE3pLJJQ-1; Fri, 18 Aug 2023 09:33:39 -0400
X-MC-Unique: EJIL4rjEN7KeEtSE3pLJJQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 37D5B29AA38A;
        Fri, 18 Aug 2023 13:33:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8A45E1121314;
        Fri, 18 Aug 2023 13:33:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wg8G7teERgR7ExNUjHj0yx3dNRopjefnN3zOWWvYADXCw@mail.gmail.com>
References: <CAHk-=wg8G7teERgR7ExNUjHj0yx3dNRopjefnN3zOWWvYADXCw@mail.gmail.com> <03730b50cebb4a349ad8667373bb8127@AcuMS.aculab.com> <20230816120741.534415-1-dhowells@redhat.com> <20230816120741.534415-3-dhowells@redhat.com> <608853.1692190847@warthog.procyon.org.uk> <3dabec5643b24534a1c1c51894798047@AcuMS.aculab.com> <CAHk-=wjFrVp6srTBsMKV8LBjCEO0bRDYXm-KYrq7oRk0TGr6HA@mail.gmail.com> <665724.1692218114@warthog.procyon.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, David Laight <David.Laight@aculab.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iov_iter: Don't deal with iter->copy_mc in memcpy_from_iter_mc()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1936663.1692365615.1@warthog.procyon.org.uk>
Date:   Fri, 18 Aug 2023 14:33:35 +0100
Message-ID: <1936666.1692365615@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> This patch only does that for the 'user_backed' thing, which was a similar
> case.

It makes some things a bit bigger, makes some a bit smaller:

__iov_iter_get_pages_alloc               dcr 0x331 -> 0x32a -0x7
_copy_from_iter                          dcr 0x36e -> 0x36a -0x4
_copy_from_iter_flushcache               inc 0x359 -> 0x36b +0x12
_copy_mc_to_iter                         dcr 0x3a7 -> 0x39b -0xc
_copy_to_iter                            inc 0x358 -> 0x359 +0x1
copy_page_to_iter_nofault.part.0         dcr 0x3f1 -> 0x3ef -0x2
csum_and_copy_from_iter                  dcr 0x3e8 -> 0x3e4 -0x4
csum_and_copy_to_iter                    inc 0x46a -> 0x46d +0x3
dup_iter                                 inc 0x34 -> 0x39 +0x5
fault_in_iov_iter_readable               inc 0x9b -> 0xa0 +0x5
fault_in_iov_iter_writeable              inc 0x9b -> 0xa0 +0x5
first_iovec_segment                      inc 0x4a -> 0x51 +0x7
import_single_range                      dcr 0x62 -> 0x40 -0x22
import_ubuf                              dcr 0x65 -> 0x43 -0x22
iov_iter_advance                         inc 0xd7 -> 0x103 +0x2c
iov_iter_alignment                       inc 0xe0 -> 0xe2 +0x2
iov_iter_extract_pages                   dcr 0x418 -> 0x416 -0x2
iov_iter_init                            dcr 0x31 -> 0x27 -0xa
iov_iter_is_aligned                      inc 0xf3 -> 0x108 +0x15
iov_iter_npages                          inc 0x119 -> 0x11a +0x1
iov_iter_revert                          inc 0x88 -> 0x99 +0x11
iov_iter_single_seg_count                inc 0x38 -> 0x3e +0x6
iov_iter_ubuf                            new 0x39
iov_iter_zero                            inc 0x34f -> 0x353 +0x4
iter_iov                                 new 0x17

Adding an extra patch to get rid of the bitfields and using a u8 for the type
and bools for the flags makes very little difference on top of the above:

__iov_iter_get_pages_alloc               inc 0x32a -> 0x32f +0x5
_copy_from_iter                          inc 0x36a -> 0x36d +0x3
copy_page_from_iter_atomic.part.0        inc 0x3cf -> 0x3d2 +0x3
csum_and_copy_to_iter                    dcr 0x46d -> 0x46a -0x3
iov_iter_advance                         dcr 0x103 -> 0xfd -0x6
iov_iter_extract_pages                   inc 0x416 -> 0x417 +0x1
iov_iter_init                            inc 0x27 -> 0x2d +0x6
iov_iter_revert                          dcr 0x99 -> 0x95 -0x4

For reference, I generated the stats with:

	nm build3/lib/iov_iter.o  | sort >a
	... change...
	nm build3/lib/iov_iter.o  | sort >b
	perl analyse.pl a b

where analyse.pl is attached.

David
---
#!/usr/bin/perl -w
use strict;

die "$0 <file_a> <file_b>" if ($#ARGV != 1);
my ($file_a, $file_b) = @ARGV;
die "$file_a: File not found\n" unless -r $file_a;
die "$file_b: File not found\n" unless -r $file_b;

my %a = ();
my %b = ();
my %c = ();

sub read_one($$$)
{
    my ($file, $list, $all) = @_;
    my $last = undef;

    open FD, "<$file" || die $file;
    while (<FD>) {
	if (/([0-9a-f][0-9a-f]+) [Tt] ([_a-zA-Z0-9.]*)/) {
	    my $addr = hex $1;
	    my $sym = $2;
	    #print $addr, " ", $sym, "\n";

	    my %obj = (
		sym	=> $sym,
		addr	=> $addr,
		size	=> 0
		);

	    $list->{$sym} = \%obj;
	    $all->{$sym} = 1;

	    if ($last) {
		$last->{size} = $addr - $last->{addr};
	    }

	    $last = \%obj;
	}
    }
    close(FD);
}

read_one($file_a, \%a, \%c);
read_one($file_b, \%b, \%c);

foreach my $sym (sort keys %c) {
    my $as = -1;
    my $bs = -1;

    $as = $a{$sym}->{size} if (exists($a{$sym}));
    $bs = $b{$sym}->{size} if (exists($b{$sym}));

    next if ($as == $bs);
    #next if ($sym =~ /__UNIQUE_ID/);

    if ($as == -1) {
	printf "%-40s new 0x%x\n", $sym, $bs;
    } elsif ($bs == -1) {
	printf "%-40s del 0x%x\n", $sym, $as;
    } elsif ($bs > $as) {
	printf "%-40s inc 0x%x -> 0x%x +0x%x\n", $sym, $as, $bs, $bs - $as;
    } else {
	printf "%-40s dcr 0x%x -> 0x%x -0x%x\n", $sym, $as, $bs, $as - $bs;
    }
}

