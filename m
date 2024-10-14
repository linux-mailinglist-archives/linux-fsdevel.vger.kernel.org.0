Return-Path: <linux-fsdevel+bounces-31904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5FA99D43B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 18:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C223B2884C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 16:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F040C1AC427;
	Mon, 14 Oct 2024 16:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rpncipIO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8ZzdkTk3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rpncipIO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8ZzdkTk3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8961A1AB53A
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Oct 2024 16:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728922003; cv=none; b=Atnnv+nck46N0H5BpACc2kmBt+QODHxzFl4XeElytdFChTpYTXP/YqdWSwd0JpnusSOn/BqHhBeGxaJU15Qa6Uu9h4IVa4ZZnyvyqtqZd1v6OQEtMz6l7K+L71sNejUYrmRzVKuW21vZqIQnk1vPHOPn4r5AAPSOQE1mkly0GlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728922003; c=relaxed/simple;
	bh=ddIORdJKoUIcva42rw2gozuF6shtST2TOBbLCT1idJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECq15U6WGUMsxd2cexoGTJbq4eoTRdwRC+bBySTF4Z5Vy9L4rp4vzZWtmE39F3Wet34i5MKmF7z7JuHzadwGXowjYmIuTVmouCb577u5BIop4oFIluIlJd3xMyO1TEQxhnXMWSUZCiXyvqQ+OLCnr7TvpNEmR67EMq6oWMrBTgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rpncipIO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8ZzdkTk3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rpncipIO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8ZzdkTk3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B59A71F79A;
	Mon, 14 Oct 2024 16:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728921999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i57PMbwGhDtudbHExR7YlY3CfVGc3dyKRxf3yHLGdI4=;
	b=rpncipIO0KjeDddfdhRFGxNqA2qY2iuHsC1FjgzstOCBYc9+Sbu2VhLoEYME4dArFoicrX
	leB74+DJfBp8Ay4s2gkMHVKT+PmpBQVaz2l+A+1RMHo7xBoXB/fjU0mAzkn48nVGvOHkdp
	szUvos2ulJwk47t13XJXJ5SKvz7dXM8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728921999;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i57PMbwGhDtudbHExR7YlY3CfVGc3dyKRxf3yHLGdI4=;
	b=8ZzdkTk3E5YadhH+uXv7wexUzA3O2ejlRYhwq0KUNGVmeHPzGNLu3x/lQJbeCKzisMZbCg
	sRSpTFqEOvFSneDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728921999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i57PMbwGhDtudbHExR7YlY3CfVGc3dyKRxf3yHLGdI4=;
	b=rpncipIO0KjeDddfdhRFGxNqA2qY2iuHsC1FjgzstOCBYc9+Sbu2VhLoEYME4dArFoicrX
	leB74+DJfBp8Ay4s2gkMHVKT+PmpBQVaz2l+A+1RMHo7xBoXB/fjU0mAzkn48nVGvOHkdp
	szUvos2ulJwk47t13XJXJ5SKvz7dXM8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728921999;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i57PMbwGhDtudbHExR7YlY3CfVGc3dyKRxf3yHLGdI4=;
	b=8ZzdkTk3E5YadhH+uXv7wexUzA3O2ejlRYhwq0KUNGVmeHPzGNLu3x/lQJbeCKzisMZbCg
	sRSpTFqEOvFSneDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC38A13A51;
	Mon, 14 Oct 2024 16:06:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WaIHKo9BDWeHBwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 14 Oct 2024 16:06:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6720FA08E1; Mon, 14 Oct 2024 18:06:39 +0200 (CEST)
Date: Mon, 14 Oct 2024 18:06:39 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Aleksa Sarai <cyphar@cyphar.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC] : fhandle: relax open_by_handle_at() permission
 checks
Message-ID: <20241014160639.hwc2pvhrlqys75hk@quack3>
References: <20240524-vfs-open_by_handle_at-v1-1-3d4b7d22736b@kernel.org>
 <CAOQ4uxhjQwvJZEcuPyOg02rcDgcLfHQL-zhUGUmTf1VD8cCg4w@mail.gmail.com>
 <CAOQ4uxgjY=upKo7Ry9NxahJHhU8jV193EjsRbK80=yXd5yikYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgjY=upKo7Ry9NxahJHhU8jV193EjsRbK80=yXd5yikYg@mail.gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.19)[-0.963];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -3.79
X-Spam-Flag: NO

On Sun 13-10-24 18:34:18, Amir Goldstein wrote:
> On Fri, May 24, 2024 at 2:35 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > On Fri, May 24, 2024 at 1:19 PM Christian Brauner <brauner@kernel.org> wrote:
> > AFAICT, the only thing that currently makes this impossible in this patch
> > is the O_DIRECTORY limitation.
> > Because there could be non-directory non-hashed aliases of deleted
> > files in dcache.
> >
> 
> This limitation, that you added to my request, has implications on
> fanotify (TLDR):
> 
> file handles reported in fanotify events extra info of type
> FAN_EVENT_INFO_TYPE_DFID{,_NAME} due to fanotify_inide()
> flag FAN_REPORT_DIR_FID are eligible for open_by_handle_at(2)
> inside non-root userns and FAN_REPORT_DFID_NAME is indeed
> the most expected use case - namely
> directory file handle can always be used to find the parent's path
> and the name of the child entry is provided in the event.
> 
> HOWEVER,
> with fanotify_init() flags FAN_REPORT_{TARGET_,}FID
> the child file handle is reported additionally, using extra info type
> FAN_EVENT_INFO_TYPE_FID and this file handle may not be
> eligible for open_by_handle_at(2) inside non-root userns,
> because it could be resolved to a disconnected dentry, for which
> permission cannot be checked.
> 
> I don't think this is a problem - the child fid is supposed to
> be used as an extra check to verify with name_to_handle_at()
> that the parent dir and child name refer to the same object as
> the one reported with the child fid.
> But it can be a bit confusing to users that some file handles
> (FAN_EVENT_INFO_TYPE_DFID) can be decoded and some
> (FAN_EVENT_INFO_TYPE_FID) cannot, so this hairy detail
> will need to be documented.

Well, I think the explanation that open_by_handle_at() works only for
directories inside containers is clear enough explanation. It has nothing
to do with whether the FID comes from FAN_EVENT_INFO_TYPE_DFID or from
FAN_EVENT_INFO_TYPE_FID.

> In retrospect, for unpriv fanotify, we should not have allowed
> the basic mode FAN_REPORT_FID, which does not make a
> distinction between directory and non-dir file handles.

I don't think we could have forseen these changes. Also I don't think the
interface is wrong per se. Just the handle cannot be used with
open_by_handle_at() if it points to a regular file so it may be annoying to
use but we didn't expect the handle will ever be usable with
open_by_handle_at() for unpriviledged users so making it usable for
directories can be seen as an improvement :). Realistically I think
unpriviledged users will use FAN_EVENT_INFO_TYPE_DFID_NAME to avoid these
headaches.
 
> Jan, do you think we should deny the FAN_REPORT_FID mode
> with non-root userns sb/mount watches to reduce some unneeded
> rows in the test matrix?

I think this would be a bit arbitrary restriction. I don't see how
supporting FAN_REPORT_FID would be making our life any harder.

> Any other thoughts regarding non-root userns sb/mount watches?

No, not really.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

