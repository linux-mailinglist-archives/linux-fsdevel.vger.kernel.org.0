Return-Path: <linux-fsdevel+bounces-42015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1CAA3ABD0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 23:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2558B188B3CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 22:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1451DAC9C;
	Tue, 18 Feb 2025 22:37:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D04C1D934C
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 22:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739918274; cv=none; b=dIwJGuhDCjXXqjHj/KFroERmeLWn+nGSjiV9vnLQ8zSyPcDEKEdy84VnPrl2o3/jm/SsvGHGnpiXL+mYs4Z7arrXKH9QtRlTMTdoIVhW/lpoCtua/ItEUSodwp21v2wocb9V22l6bLMO0XnnXBmOU53vBPq/ghczwdeSX+RAXy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739918274; c=relaxed/simple;
	bh=9a7qjUliItQyUaZ2CtBHKhSQAqMoB5ZnaUnBZhhavGY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Mr64CmzH/OoGZFkjSqRR4t5SF3Oo1og3CEKGXK5TrPq8BbYdcSoV0lRVcS2Ub5F2H17tQXAeK21DVTnb1zSH3bvtbeJBtzQNS9KgdcgxudLMjJoKXwAznzdwQNn3LwLFWi7IRhYSPnPrXc86sM9BzD2DwLMc5gNHZXentEClIJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de; spf=fail smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D5F672115C;
	Tue, 18 Feb 2025 22:37:45 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1425B132C7;
	Tue, 18 Feb 2025 22:37:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ssniLrcLtWfQdgAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 18 Feb 2025 22:37:43 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jan Kara" <jack@suse.cz>
Cc: "Christian Brauner" <brauner@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 1/3] Change inode_operations.mkdir to return struct dentry *
In-reply-to: <twielfhtttexj7gnhzkfm4eygx4avot4xaw63nv4winm6rjfqz@674juh7cylku>
References:
 <>, <twielfhtttexj7gnhzkfm4eygx4avot4xaw63nv4winm6rjfqz@674juh7cylku>
Date: Wed, 19 Feb 2025 09:37:41 +1100
Message-id: <173991826110.3118120.14570199015714511015@noble.neil.brown.name>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: D5F672115C
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

On Tue, 18 Feb 2025, Jan Kara wrote:
> 
> Otherwise the patch looks good to me at least for the VFS bits and the
> filesystems I understand like ext2, ext4, ocfs2, udf. So feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 

Thanks.  I've made the suggested changes and added the Reviewed-by.

NeilBrown

