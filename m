Return-Path: <linux-fsdevel+bounces-1257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C38147D8656
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 17:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DA75B21225
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 15:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143A4381A0;
	Thu, 26 Oct 2023 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Afj+o1Dr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="245PR0c2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9CE2F509
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 15:58:50 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FA39D
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 08:58:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 39FE31FE64;
	Thu, 26 Oct 2023 15:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1698335928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/bu6MjAFCyQ9DJEPppeSw+up3lyYRSHTM5LbTME43Lw=;
	b=Afj+o1Drloq5FOczRCLzkudhiFQYu3Z7Q/336T1cnOym7akW0gctZ0nYkVf7whKTixk9ta
	g/7i7mswiyG7Gia5wVqJ9pddzZWwPxI8BiFFExFlywbcVk/0cA952bwONy1/9tfr5Z4b6P
	G5pL4+9uS4YD6MIQp63JCne+3SWqmis=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1698335928;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/bu6MjAFCyQ9DJEPppeSw+up3lyYRSHTM5LbTME43Lw=;
	b=245PR0c29Rh9AFICs252nFX19eWZVKTMReaJ0Q2BmqyppUoBp+j4BT+LfXLEykNxb+GIlC
	RfuSNVkqg7KnYQAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2C0A5133F5;
	Thu, 26 Oct 2023 15:58:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id JIO6CriMOmXlCQAAMHmgww
	(envelope-from <jack@suse.cz>); Thu, 26 Oct 2023 15:58:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B4F88A05BC; Thu, 26 Oct 2023 17:58:47 +0200 (CEST)
Date: Thu, 26 Oct 2023 17:58:47 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 0/6] fs,block: yield devices
Message-ID: <20231026155847.ykzoi544ki5cybvu@quack3>
References: <20231024-vfs-super-rework-v1-0-37a8aa697148@kernel.org>
 <20231025172057.kl5ajjkdo3qtr2st@quack3>
 <20231025-ersuchen-restbetrag-05047ba130b5@brauner>
 <20231026103503.ldupo3nhynjjkz45@quack3>
 <20231026-marsch-tierzucht-0221d75b18ea@brauner>
 <20231026130442.lvfsjilryuxnnrp6@quack3>
 <20231026-zugreifen-impuls-15b38acf1a8c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026-zugreifen-impuls-15b38acf1a8c@brauner>

On Thu 26-10-23 17:08:00, Christian Brauner wrote:
> > your taste it could be also viewed as kind of layering violation so I'm not
> > 100% convinced this is definitely a way to go.
> 
> Yeah, I'm not convinced either. As I said, I really like that right now
> ti's a vfs thing only and we don't have specific requirements about how
> devices are closed which is really nice. So let's just leave it as is?

Yes, fine by me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

