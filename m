Return-Path: <linux-fsdevel+bounces-64155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C9DBDAEFA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 20:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 260E118A16EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 18:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38FC299931;
	Tue, 14 Oct 2025 18:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mpKZlYsT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="h/8M/cNg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y9zR5ruD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iggg7o+6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D3523FC41
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 18:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760466260; cv=none; b=Pnb1DH4TbxPRdw6igM3mKv6FTCV5SPsVq9JC9iIG8OXCSu6J02Iouv78nVKtd7BEOghFein1miNT2QFQDKS9dwt8m+IQAVn1eUj/CxkE2kekFqXd+Jmi0Dc6dNkH+SySNxx3gDFKulBFiCYFgUxwNCm1jNL/wAZcUpxX/yqaoLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760466260; c=relaxed/simple;
	bh=+HW37cDy1uS12Jf9Dqt5dSXxczNSBzYFKY40FKp91aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SiVGYkwvBbP559ZQCiDHx+zuNpmggAqTXhQRhDnXjgB5nygKkaS99ESFvLlSTMpIh43duZXDiOrCRAaUJWwEMjG1ap4ws+G63iyXweTT+pWcEXQPjaYm5iOf05yXgXI4PunPUmFM98C0Ni6MoInDB6I8+J/bQTVmdwhJY3xGzdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mpKZlYsT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=h/8M/cNg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y9zR5ruD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iggg7o+6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A37B621D22;
	Tue, 14 Oct 2025 18:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760466256;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8rTIWdxiVehH5qZFo4dYlznO+npxi+WrtrmvjKWzNGA=;
	b=mpKZlYsTBlSOu4dS8dpaOSQtKuhu9K8Ls81l8eV4/zBMDKoxRmvttGVkavlTRLRm5zC70V
	1mlGejP+29uYUC8eqpUjMuRx4CTHHqX+3tmxwEcyrkCzoL+aq6ZuIV/q0qsqBd/lbh6V/V
	tul3EM1Wdz2/KT3fDxvOzpnA/cuF8wA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760466256;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8rTIWdxiVehH5qZFo4dYlznO+npxi+WrtrmvjKWzNGA=;
	b=h/8M/cNgaAw44oGl5Mlb/vpiGZI8gNPOn0VwlQtD6idtXvl5WAP18Oesl4I9MpMYhGVbfH
	78M7OR1xbwAIRcDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=y9zR5ruD;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=iggg7o+6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760466255;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8rTIWdxiVehH5qZFo4dYlznO+npxi+WrtrmvjKWzNGA=;
	b=y9zR5ruDdOlfLtDQBAwUL/e0TVl0ZWZI/FLMov1n1ttTQw/l7Nij76LtTZxEsL7JcBXA4P
	Smz+En+DuY681BgK+EQqHl5S3r3/+0u5wcEpL8uVG+fIj4pS1ZEc2ibaREax06IVMl6c95
	q2vMejijBQwOU/RgU1cwUBjHE/S+BbA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760466255;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8rTIWdxiVehH5qZFo4dYlznO+npxi+WrtrmvjKWzNGA=;
	b=iggg7o+6bFh58dTcGGF4CoE3psosmk1nVINh8poheFjzRj0w2hcINGr3+uOjopmzg4BsU6
	z+5SE9lLSrjByTDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8081413A44;
	Tue, 14 Oct 2025 18:24:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ERy+Hk+V7mgjXwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 14 Oct 2025 18:24:15 +0000
Date: Tue, 14 Oct 2025 20:24:14 +0200
From: David Sterba <dsterba@suse.cz>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kernel-dev@igalia.com, Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, Anand Jain <anand.jain@oracle.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>
Subject: Re: [RFC PATCH 0/1] ovl: brtfs' temp_fsid doesn't work with ovl
 index=on
Message-ID: <20251014182414.GD13776@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251014015707.129013-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251014015707.129013-1-andrealmeid@igalia.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: A37B621D22
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,igalia.com,szeredi.hu,gmail.com,fb.com,suse.com,oracle.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto,suse.cz:dkim,twin.jikos.cz:mid]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 

On Mon, Oct 13, 2025 at 10:57:06PM -0300, André Almeida wrote:
> Hi everyone,
> 
> When using overlayfs with the mount option index=on, the first time a directory is
> used as upper dir, overlayfs stores in a xattr "overlay.origin" the UUID of the
> filesystem being used in the layers. If the upper dir is reused, overlayfs
> refuses to mount for a different filesystem, by comparing the UUID with what's
> stored at overlay.origin, and it fails with "failed to verify upper root origin"
> on dmesg. Remounting with the very same fs is supported and works fine.
> 
> However, btrfs mounts may have volatiles UUIDs. When mounting the exact same
> disk image with btrfs, a random UUID is assigned for the following disks each
> time they are mounted, stored at temp_fsid and used across the kernel as the
> disk UUID. `btrfs filesystem show` presents that. Calling statfs() however shows
> the original (and duplicated) UUID for all disks.
> 
> This feature doesn't work well with overlayfs with index=on, as when the image
> is mounted a second time, will get a different UUID and ovl will refuse to
> mount, breaking the user expectation that using the same image should work. A
> small script can be find in the end of this cover letter that illustrates this.
> 
> >From this, I can think of some options:
> 
> - Use statfs() internally to always get the fsid, that is persistent. The patch
> here illustrates that approach, but doesn't fully implement it.
> - Create a new sb op, called get_uuid() so the filesystem returns what's
> appropriated.
> - Have a workaround in ovl for btrfs.
> - Document this as unsupported, and userland needs to erase overlay.origin each
> time it wants to remount.
> - If ovl detects that temp_fsid and index are being used at the same time,
> refuses to mount.
> 
> I'm not sure which one would be better here, so I would like to hear some ideas
> on this.

I haven't looked deeper if there's a workable solution, but the feature
combination should be refused. I don't think this will affect many
users.

