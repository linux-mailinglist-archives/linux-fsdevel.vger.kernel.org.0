Return-Path: <linux-fsdevel+bounces-59-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0504D7C53CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 14:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DCBF2825C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 12:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8912A1F180;
	Wed, 11 Oct 2023 12:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KA8coRex";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GsHa4Hp5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AC81F18A
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 12:23:55 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65006101
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 05:23:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A4E37211E1;
	Wed, 11 Oct 2023 12:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1697027027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=IXJD5jzMDmwrCenWs0/V7NeGI3jyUJkKofMVrxfCu0g=;
	b=KA8coRexxsLzRXj/AmUf62loENijPz1vV6DRdPIsDa90BXK9ElbigsmxDM8BQgsKsYrzhP
	h2KLO2dq6ch+PdkEQLz1q1fn1+r5fR9Vz8GOSeFyly73JYe3kzEIfPzlIV+yH4ZX37I6Nq
	Rw4ZCpjyItGVMXVr9IpM5Djd20X/WRI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1697027027;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=IXJD5jzMDmwrCenWs0/V7NeGI3jyUJkKofMVrxfCu0g=;
	b=GsHa4Hp5MyVVluPsllZHXAtI3xRlMR8zhqYQJURdiX7Ka7LxTKilg0ruy59xV1WBsw42gq
	dvzDLrv4A4kbtKAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 92625138EF;
	Wed, 11 Oct 2023 12:23:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id sXOwI9OTJmWhJwAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 11 Oct 2023 12:23:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 170EBA05BC; Wed, 11 Oct 2023 14:23:47 +0200 (CEST)
Date: Wed, 11 Oct 2023 14:23:47 +0200
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] quota regression fix for 6.6-rc6
Message-ID: <20231011122347.zf33iokgq3yl6e77@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.17
X-Spamd-Result: default: False [-0.17 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWO(0.00)[2];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.57)[81.21%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.6-rc6

to get a fix of a quota regression introduced by UAF fix in 6.6-rc1
(details in the commit log).

Top of the tree is 869b6ea1609f. The full shortlog is:

Jan Kara (1):
      quota: Fix slow quotaoff

The diffstat is

 fs/quota/dquot.c         | 66 ++++++++++++++++++++++++++++--------------------
 include/linux/quota.h    |  4 ++-
 include/linux/quotaops.h |  2 +-
 3 files changed, 43 insertions(+), 29 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

