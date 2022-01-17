Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9923C491204
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 23:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238413AbiAQW51 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 17:57:27 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:57186 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiAQW50 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 17:57:26 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4DCBD212C6;
        Mon, 17 Jan 2022 22:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642460245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P7n87uEdX6AP7WiZCRETbtzvEHDHupG/dHaxrwEAQC8=;
        b=IIp0lRCZ46tjOlNYdKtcQvs4fMVMos27RVH1sts3oeBtQ++NY4e/Bg7ORS0HB+r/0jR7w9
        KhwiE03oScvFl1sJD5UkMFQEA6zQ0bAEhlSacM/0Io7G0SqlrGXelAlkT5J9wR8JYef3oL
        Un0vYOE3FfRoAIqbzxGYGQkkVFqEiYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642460245;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P7n87uEdX6AP7WiZCRETbtzvEHDHupG/dHaxrwEAQC8=;
        b=oiXsTGkzXw7eP/0rTLj8LfUczvFMyqm38HLIOw0dEdqaNm6GyrqdqlRGs5q8a8dVkoGhD1
        k1Y4JajvAaC7YbAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A4D5213EA9;
        Mon, 17 Jan 2022 22:57:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id x4U/GFL05WE3DQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 17 Jan 2022 22:57:22 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     "Al Viro" <viro@zeniv.linux.org.uk>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Christian Brauner" <christian.brauner@ubuntu.com>,
        "Anthony Iliopoulos" <ailiop@suse.com>,
        "David Howells" <dhowells@redhat.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "LKML" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH - resend] devtmpfs regression fix: reconfigure on each mount
In-reply-to: <CAHk-=wiLi2_JJ1+VnhZ3aWr_cag7rVxbhpf6zKVrOuRHMsfQ4Q@mail.gmail.com>
References: <163935794678.22433.16837658353666486857@noble.neil.brown.name>,
 <20211213125906.ngqbjsywxwibvcuq@wittgenstein>, <YbexPXpuI8RdOb8q@technoir>,
 <20211214101207.6yyp7x7hj2nmrmvi@wittgenstein>, <Ybik5dWF2w06JQM6@technoir>,
 <20211214141824.fvmtwvp57pqg7ost@wittgenstein>,
 <164237084692.24166.3761469608708322913@noble.neil.brown.name>,
 <CAHk-=wiLi2_JJ1+VnhZ3aWr_cag7rVxbhpf6zKVrOuRHMsfQ4Q@mail.gmail.com>
Date:   Tue, 18 Jan 2022 09:57:19 +1100
Message-id: <164246023981.24166.3391008944843186406@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 17 Jan 2022, Linus Torvalds wrote:
> On Mon, Jan 17, 2022 at 12:07 AM NeilBrown <neilb@suse.de> wrote:
> >
> > Since that was changed, the mount options used for devtmpfs are ignored.
> > This is a regression which affect systemd - which mounts devtmpfs
> > with "-o mode=755,size=4m,nr_inodes=1m".
> 
> Hmm, I've applied this, but I'd have loved to see what the actual
> symptoms of the problem were. Particularly since it's apparently been
> broken for 18 months with this being the first I hear of it.
> 
> Yes, yes, I could (and did) search for this on the mailing lists, and
> found the discussion and more information, but I think that info
> should have been in the commit message rather than me having to go
> look for it just to see the clarifications..

Sorry about that.  The trail was a bit convoluted and I hadn't bothered
to straighten it out as the behavioural change was so easy to
demonstrate.

I've had a better look now.
A customer with a 5.3 based kernel reported that udev was having
problems creating all the symlinks for lots of LUNs for some storage
array (With dm devices over the LUNs etc).
It ran out of inodes because systemd always mounts devtmpfs with 
  size=4m,nr_inodes=64k
This was bumped to 128k and then to 1m in systemd-v250.

We provided our customer with a systemd which used a larger limit, but
when we tested this fix on Tumbleweed (with a newer kernel), we noticed
that it had no effect.

Now admittedly the default provided by the kernel is a lot bigger than
even the current 1m setting from systemd so maybe this doesn't matter.
Had the commit which changed behaviour said "systemd sets nr_inodes to a
stupidly low number, let's just ignore the mount options", then I
probably would have accept it.  But it looked like behaviour change
without justification and that suggests a regression. So I patched it.

Thanks,
NeilBrown
