Return-Path: <linux-fsdevel+bounces-60-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 897227C53F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 14:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E02A52822B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 12:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C661F190;
	Wed, 11 Oct 2023 12:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="d1ouo4ys";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KNdLDwJc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED311F17F
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 12:27:35 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C379DB;
	Wed, 11 Oct 2023 05:27:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 04C211FEAA;
	Wed, 11 Oct 2023 12:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1697027252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XLGYNIpBGTpFoman1F31pR+A7u+/GIIcO6T6txA/HVQ=;
	b=d1ouo4yssFmMN4hXj7YbQ1/bxrm535wo+ovssb3YHlZbR9cXMgnQOp+JhjK+IePE4+qlqj
	8zBlPV09rDCPNnimAInT+7TBIrkCZLcKlaQ7NnFWt7HNxWPySd9+tivCWbsAG0HQOcTHKq
	KiZqbYGPvk/dt/LL76CA3TPCmXGVm00=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1697027252;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XLGYNIpBGTpFoman1F31pR+A7u+/GIIcO6T6txA/HVQ=;
	b=KNdLDwJcimYu5q45lemc7ttQM9SKBG6AuDTAgenwRrOrrOKp8yr3lxkef5StxJdndiKa6b
	oQ5saYsh2tXbveAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E6128138EF;
	Wed, 11 Oct 2023 12:27:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id JxQdOLOUJmWvKQAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 11 Oct 2023 12:27:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5C882A05BC; Wed, 11 Oct 2023 14:27:31 +0200 (CEST)
Date: Wed, 11 Oct 2023 14:27:31 +0200
From: Jan Kara <jack@suse.cz>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Jan Kara <jack@suse.cz>, Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>, Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.com>, Dave Kleikamp <shaggy@kernel.org>,
	ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
	Christian Brauner <brauner@kernel.org>,
	Yang Xu <xuyang2018.jy@fujitsu.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fs/{posix_acl,ext2,jfs,ceph}: apply umask if ACL
 support is disabled
Message-ID: <20231011122731.qhxvdvzfub53t5v2@quack3>
References: <69dda7be-d7c8-401f-89f3-7a5ca5550e2f@oracle.com>
 <20231009144340.418904-1-max.kellermann@ionos.com>
 <20231010131125.3uyfkqbcetfcqsve@quack3>
 <CAKPOu+-nC2bQTZYL0XTzJL6Tx4Pi1gLfNWCjU2Qz1f_5CbJc1w@mail.gmail.com>
 <20231011100541.sfn3prgtmp7hk2oj@quack3>
 <CAKPOu+_xdFALt9sgdd5w66Ab6KTqiy8+Z0Yd3Ss4+92jh8nCwg@mail.gmail.com>
 <20231011120655.ndb7bfasptjym3wl@quack3>
 <CAKPOu+-hLrrpZShHh0o6uc_KMW91suEd0_V_uzp5vMf4NM-8yw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKPOu+-hLrrpZShHh0o6uc_KMW91suEd0_V_uzp5vMf4NM-8yw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed 11-10-23 14:18:45, Max Kellermann wrote:
> On Wed, Oct 11, 2023 at 2:07 PM Jan Kara <jack@suse.cz> wrote:
> > Indeed, *that* looks like a bug. Good spotting! I'd say posix_acl_create()
> > defined in include/linux/posix_acl.h for the !CONFIG_FS_POSIX_ACL case
> > should be stripping mode using umask. Care to send a patch for this?
> 
> You mean like the patch you're commenting on right now? ;-)

Yeah, OK, that was a bit silly ;) I was too concentrated on the filesystem
bits.

> But without the other filesystems. I'll resend it with just the
> posix_acl.h hunk.

Yup, and a bit massaged changelog... Thanks a lot!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

