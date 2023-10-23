Return-Path: <linux-fsdevel+bounces-939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EACAB7D3CA3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 18:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A32D4281554
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 16:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC87200C5;
	Mon, 23 Oct 2023 16:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qs0B9/vy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a5q541TZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF7C1F5EA
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 16:33:13 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7176E4;
	Mon, 23 Oct 2023 09:33:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3E01921883;
	Mon, 23 Oct 2023 16:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1698078789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pkUZdvsSSaDISx+RdjKJSrvLwGsv/XeNdUS+HV1/3Ug=;
	b=qs0B9/vyx0wmHrmxIW/YeFn8p93gVPq8fBS0buXVxpqrL82Eq1BFJ8hEwckJMghMUaehgb
	aZdPwFfgOqs9EzPBnMak3Op85qWFFhdJfTene5pKDP2ao0NvaaAs/Uv5ZTpo8+j53CU36z
	GVkM+sLRl/Gdw9oNKtwKbAYq7T+8APA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1698078789;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pkUZdvsSSaDISx+RdjKJSrvLwGsv/XeNdUS+HV1/3Ug=;
	b=a5q541TZqQ+U74KFYIJy2N1za4C8a8c78H8ItImld4bVulZVR9kIZHQrfcf8C12jy1PrKg
	bcKM9rBGw+Mg3uCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2D377139C2;
	Mon, 23 Oct 2023 16:33:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id iqP4CkWgNmXAMwAAMHmgww
	(envelope-from <jack@suse.cz>); Mon, 23 Oct 2023 16:33:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AFBDCA06B2; Mon, 23 Oct 2023 18:33:08 +0200 (CEST)
Date: Mon, 23 Oct 2023 18:33:08 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 5/5] exportfs: support encoding non-decodeable file
 handles by default
Message-ID: <20231023163308.7szzloiuzzc7lnia@quack3>
References: <20231018100000.2453965-1-amir73il@gmail.com>
 <20231018100000.2453965-6-amir73il@gmail.com>
 <CAOQ4uxhiRU2nNnYtuXUaURMCuYjssC9Rn=ORWW=MmVyMD1H6Rg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhiRU2nNnYtuXUaURMCuYjssC9Rn=ORWW=MmVyMD1H6Rg@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -6.60
X-Spamd-Result: default: False [-6.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

On Mon 23-10-23 16:55:40, Amir Goldstein wrote:
> On Wed, Oct 18, 2023 at 1:00 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > AT_HANDLE_FID was added as an API for name_to_handle_at() that request
> > the encoding of a file id, which is not intended to be decoded.
> >
> > This file id is used by fanotify to describe objects in events.
> >
> > So far, overlayfs is the only filesystem that supports encoding
> > non-decodeable file ids, by providing export_operations with an
> > ->encode_fh() method and without a ->decode_fh() method.
> >
> > Add support for encoding non-decodeable file ids to all the filesystems
> > that do not provide export_operations, by encoding a file id of type
> > FILEID_INO64_GEN from { i_ino, i_generation }.
> >
> > A filesystem may that does not support NFS export, can opt-out of
> > encoding non-decodeable file ids for fanotify by defining an empty
> > export_operations struct (i.e. with a NULL ->encode_fh() method).
> >
> > This allows the use of fanotify events with file ids on filesystems
> > like 9p which do not support NFS export to bring fanotify in feature
> > parity with inotify on those filesystems.
> >
> > Note that fanotify also requires that the filesystems report a non-null
> > fsid.  Currently, many simple filesystems that have support for inotify
> > (e.g. debugfs, tracefs, sysfs) report a null fsid, so can still not be
> > used with fanotify in file id reporting mode.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> 
> Hi Jan,
> 
> Did you get a chance to look at this patch?
> I saw your review comments on the rest of the series, so was waiting
> for feedback on this last one before posting v2.

Ah, sorry. I don't have any further comments regarding this patch besides
what Chuck already wrote.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

