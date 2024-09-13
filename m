Return-Path: <linux-fsdevel+bounces-29339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C08A89784D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 17:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41E501F28B2B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 15:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BD93B782;
	Fri, 13 Sep 2024 15:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yVwjLDjf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="POHN8jUU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zj1xRwzn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="c2V/VfpG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD51239FD0;
	Fri, 13 Sep 2024 15:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726241209; cv=none; b=F3XJ6iKfxAkiFO+o6eSt/m9I2AU1aAEdS/h+JqduRjhTQjiAbQvZ6lzVnCtQYga8EJZuA5KixPwRdNLut+0CpPUmDmfotvVAAlM+W1Wa99E8BCMSDhwkT4hXG1xcmyPf6GbvamrJlpsUOvuMlvKgeAqkHeOnSY3Id6Ly1gZOz/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726241209; c=relaxed/simple;
	bh=PF3fhLUrOAqqkJ+0HFZ9G85pt2ptVKQzNDwuxW49rgA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PPAMJKPNXwF6q4tGt3oOfoS183FbRK/ZuNRlE9BTjBQkptbjMuhxpLNm5qIcvEdFwVMgKgbeo3HTDvP/G5BEysbpgOqVV/RQQtlTVN6VJGkMxVNhr7esmE9aOsWV+RAh68pQv3JtSb5uHK8YU4LvyMpPkaNoL0GEl0URCpLvk7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yVwjLDjf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=POHN8jUU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zj1xRwzn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=c2V/VfpG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 81B762195F;
	Fri, 13 Sep 2024 15:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726241205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+XPXj5EiF2w+e7qpWsO5Q2nBeq/fL4ElLZkLBqg7ujM=;
	b=yVwjLDjfgBRZOMTRPvyFd/9Mc55asqx+6KfBcRD+8S0xmyjIIOcB7RAtuOpXx91pSzi5N8
	MDBRpghKPulZBIBwZflLpOZbxluyafwtXChTr8eGyh0y5l91VEGLPZGM19VCSkU7b7fKJV
	27VFCdMg7a+zgztyGFqfUcVWnJ3ZY7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726241205;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+XPXj5EiF2w+e7qpWsO5Q2nBeq/fL4ElLZkLBqg7ujM=;
	b=POHN8jUUUweHX897rXuh1TAkG5+rXFix5L3igL70FQKtBhmc+ZdvWztQBnmddIEtSuDH5l
	VGKknpudRfREhvAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zj1xRwzn;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="c2V/VfpG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726241204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+XPXj5EiF2w+e7qpWsO5Q2nBeq/fL4ElLZkLBqg7ujM=;
	b=zj1xRwznD8XAC27o8OHBNPcGN5NrmsmQ3zAlM++aP79EEkfbIdkYplu7RDTnwmvxBUymWw
	BHH8H9hGjrz7+KQlWB2qfpR/rhYFNIaws5UdNPIwhs3PYkD4PaJxeNu6vw19G30Z+ZCMO4
	TJ3hPH/WfajZ6zAL12vU5NCHGW3Hj3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726241204;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+XPXj5EiF2w+e7qpWsO5Q2nBeq/fL4ElLZkLBqg7ujM=;
	b=c2V/VfpG4MabXswu/MWhHbJYufTN0+ZicvarKeEwia71AeBYqdb3BnalYqLqyIRJ9vRG98
	A+UHF11iu38qSMCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4707813999;
	Fri, 13 Sep 2024 15:26:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iKtIC7RZ5GbbTAAAD6G6ig
	(envelope-from <krisman@suse.de>); Fri, 13 Sep 2024 15:26:44 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: ganjie <ganjie182@gmail.com>
Cc: krisman@suse.de,  linux-fsdevel@vger.kernel.org,  hch@lst.de,
  linux-kernel@vger.kernel.org,  guoxuenan@huawei.com,
  guoxuenan@huaweicloud.com
Subject: Re: [PATCH v2] unicode: change the reference of database file
In-Reply-To: <20240912031932.1161-1-ganjie182@gmail.com> (ganjie's message of
	"Thu, 12 Sep 2024 11:19:32 +0800")
Organization: SUSE
References: <20240912031932.1161-1-ganjie182@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Fri, 13 Sep 2024 11:26:42 -0400
Message-ID: <8734m3k219.fsf@mailhost.krisman.be>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 81B762195F
X-Spam-Score: -6.50
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.50 / 50.00];
	BAYES_HAM(-2.99)[99.94%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,mailhost.krisman.be:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

ganjie <ganjie182@gmail.com> writes:

> From: Gan Jie <ganjie182@gmail.com>
>
> Commit 2b3d04787012 ("unicode: Add utf8-data module") changed
> the database file from 'utf8data.h' to 'utf8data.c' to build
> separate module, but it seems forgot to update README.utf8data
> , which may causes confusion. Update the README.utf8data and
> the default 'UTF8_NAME' in 'mkutf8data.c'.
>
> Signed-off-by: Gan Jie <ganjie182@gmail.com>

Applied. thank you!

-- 
Gabriel Krisman Bertazi

