Return-Path: <linux-fsdevel+bounces-28533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DCA96B84D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 12:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80BAC283D1B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 10:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28591CF5E7;
	Wed,  4 Sep 2024 10:23:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EAE1BD4E9;
	Wed,  4 Sep 2024 10:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445418; cv=none; b=X7qOpOWXiPrfDUkz8hDJIYk2OHDrDxtRNlyx+2vbTVpklGxADE0nbPFxdlJhr5DKkPk/CCL4AHWvsnZNx93uvdzKq9eO2vUPCRZiP40Ff4TnIF9J0Reifu+w1apQGI1Y6ycwIm/mlmzLUZXwBsEeP6mgluKlOw/CQuI2rnoUq7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445418; c=relaxed/simple;
	bh=a38Jd1/NRnPhHmg1CPPXqGxYX5cTaTZlx/zAtYGpOuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0Dez6vaHDH/oouzR/76E6six/zjMVpampoDRctrOU51klOmLCC3Lwp6GSz8gX0dHfhtAh2kGG3fmyPs08oEEumra+F87x088AOK/63fqpkdDnRPYz6w8Pnz19eK6BoERidiy3uEoJP97Y1s4ekfzEZJGv4YNzBNdUaLP3D+O88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 031EE21A0C;
	Wed,  4 Sep 2024 10:23:35 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECC20139D2;
	Wed,  4 Sep 2024 10:23:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VSnKOSY12GbrJwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Sep 2024 10:23:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7FF20A0968; Wed,  4 Sep 2024 12:23:34 +0200 (CEST)
Date: Wed, 4 Sep 2024 12:23:34 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v3 04/12] ext4: let __revise_pending() return newly
 inserted pendings
Message-ID: <20240904102334.a2th4zv4szuae7by@quack3>
References: <20240813123452.2824659-1-yi.zhang@huaweicloud.com>
 <20240813123452.2824659-5-yi.zhang@huaweicloud.com>
 <20240904101515.2v2pwvacjltss2zk@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904101515.2v2pwvacjltss2zk@quack3>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 031EE21A0C
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

On Wed 04-09-24 12:15:15, Jan Kara wrote:
> On Tue 13-08-24 20:34:44, Zhang Yi wrote:
> > From: Zhang Yi <yi.zhang@huawei.com>
> > 
> > Let __insert_pending() return 1 after successfully inserting a new
> > pending cluster, and also let __revise_pending() to return the number of
> > of newly inserted pendings.
> > 
> > Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> AFAICS nothing really uses this functionality in this version of the
> patchset so we can drop this patch?

Now I've realized patch 6 indeed uses the new return value in one place.
This patch looks good so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

