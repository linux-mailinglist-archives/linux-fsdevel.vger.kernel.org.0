Return-Path: <linux-fsdevel+bounces-4390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D597FF2AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 15:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84A5E1C20CE3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A6851006
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v6CmOzDl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tLqm7amn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A41C4
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 05:37:09 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F32F01F8BF;
	Thu, 30 Nov 2023 13:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1701351428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b6adoP+S9QBmqehyc/TfcdDqvS0DgfBuyqugofemVAY=;
	b=v6CmOzDlfCtwlBbbeL087GY+3hIwLGGhOtYLN3Upm4Htqwizi9t0q/DAtpIz25mV/UfB6I
	jD95jqv54bJ836+jyzagMozZqim76mOYBhMUlPAsns5eE259vOHxOyto5DtTMnOrihgA2O
	lMk5W+Z1uQCFN0kjEJNGtCpKQf3w0/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1701351428;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b6adoP+S9QBmqehyc/TfcdDqvS0DgfBuyqugofemVAY=;
	b=tLqm7amnatPy/y98CIXGwk6pPSkaXDnsvvqjwcXfvTVFKSUG048g6J0U6jTgculuQ3gUIC
	0mA4Qbbskc2YBPCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E0842138E5;
	Thu, 30 Nov 2023 13:37:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id o7yGNgOQaGWQYgAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 30 Nov 2023 13:37:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 525C2A07DB; Thu, 30 Nov 2023 14:37:03 +0100 (CET)
Date: Thu, 30 Nov 2023 14:37:03 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>,
	Jan Kara <jack@suse.cz>, David Howells <dhowells@redhat.com>,
	Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2] Avert possible deadlock with splice() and fanotify
Message-ID: <20231130133703.f4xt6n53raenxgoj@quack3>
References: <20231129200709.3154370-1-amir73il@gmail.com>
 <CAOQ4uxhCC+ZpULkBf_WfsyRBToNxksesBAk5nCsGYWkuNFu6JA@mail.gmail.com>
 <CAOQ4uxhcYXzaeV=gymHN3-N-Mn30+_==5KRFzyp7Xs_nuBoMZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhcYXzaeV=gymHN3-N-Mn30+_==5KRFzyp7Xs_nuBoMZw@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.60
X-Spamd-Result: default: False [-3.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

On Thu 30-11-23 12:07:23, Amir Goldstein wrote:
> On Thu, Nov 30, 2023 at 10:32 AM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Wed, Nov 29, 2023 at 10:07 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > Christian,
> > >
> > > Josef has helped me see the light and figure out how to avoid the
> > > possible deadlock, which involves:
> > > - splice() from source file in a loop mounted fs to dest file in
> > >   a host fs, where the loop image file is
> > > - fsfreeze on host fs
> > > - write to host fs in context of fanotify permission event handler
> > >   (FAN_ACCESS_PERM) on the splice source file
> > >
> > > The first patch should not be changing any logic.
> > > I only build tested the ceph patch, so hoping to get an
> > > Acked-by/Tested-by from Jeff.
> > >
> > > The second patch rids us of the deadlock by not holding
> > > file_start_write() while reading from splice source file.
> > >
> >
> > OOPS, I missed another corner case:
> > The COPY_FILE_SPLICE fallback of server-side-copy in nfsd/ksmbd
> > needs to use the start-write-safe variant of do_splice_direct(),
> > because in this case src and dst can be on any two fs.
> > Expect an extra patch in v2.
> >
> 
> For the interested, see server-side-copy patch below.
> Pushed to branch start-write-safe [1], but will wait with v2 until
> I get comments on v1.
> 
> Thanks,
> Amir.
> 
> [1] https://github.com/amir73il/linux/commits/start-write-safe
> 
> Author: Amir Goldstein <amir73il@gmail.com>
> Date:   Thu Nov 30 11:42:50 2023 +0200
> 
>     fs: use do_splice_direct() for nfsd/ksmbd server-side-copy
> 
>     nfsd/ksmbd call vfs_copy_file_range() with flag COPY_FILE_SPLICE to
>     perform kernel copy between two files on any two filesystems.
> 
>     Splicing input file, while holding file_start_write() on the output file
>     which is on a different sb, posses a risk for fanotify related deadlocks.
> 
>     We only need to call splice_file_range() from within the context of
>     ->copy_file_range() filesystem methods with file_start_write() held.
> 
>     To avoid the possible deadlocks, always use do_splice_direct() instead of
>     splice_file_range() for the kernel copy fallback in vfs_copy_file_range()
>     without holding file_start_write().
> 
>     Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> 
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 0bc99f38e623..12583e32aa6d 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1565,11 +1565,18 @@ ssize_t vfs_copy_file_range(struct file
> *file_in, loff_t pos_in,
>          * and which filesystems do not, that will allow userspace tools to
>          * make consistent desicions w.r.t using copy_file_range().
>          *
> -        * We also get here if caller (e.g. nfsd) requested COPY_FILE_SPLICE.
> +        * We also get here if caller (e.g. nfsd) requested COPY_FILE_SPLICE
> +        * for server-side-copy between any two sb.
> +        *
> +        * In any case, we call do_splice_direct() and not splice_file_range(),
> +        * without file_start_write() held, to avoid possible deadlocks related
> +        * to splicing from input file, while file_start_write() is held on
> +        * the output file on a different sb.
>          */
> -       ret = generic_copy_file_range(file_in, pos_in, file_out, pos_out, len,
> -                                     flags);
> +       file_end_write(file_out);
> 
> +       ret = do_splice_direct(file_in, &pos_in, file_out, &pos_out,
> +                              min_t(size_t, len, MAX_RW_COUNT), 0);
>  done:
>         if (ret > 0) {
>                 fsnotify_access(file_in);
> @@ -1581,8 +1588,6 @@ ssize_t vfs_copy_file_range(struct file
> *file_in, loff_t pos_in,
>         inc_syscr(current);
>         inc_syscw(current);
> 
> -       file_end_write(file_out);
> -

This file_end_write() is also used by the paths using ->copy_file_range()
and ->remap_file_range() so you need to balance those...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

