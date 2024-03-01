Return-Path: <linux-fsdevel+bounces-13297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 437FC86E49C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 16:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE854B22D33
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 15:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D0A70044;
	Fri,  1 Mar 2024 15:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="njA5yHoq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sUUp3Ps2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="njA5yHoq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sUUp3Ps2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9173E1F95F;
	Fri,  1 Mar 2024 15:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709307933; cv=none; b=Yy3XIOULdtrXttgSCHFVta9j/mBFPCkxV1ui3KrJR+clKkXqikWRC52uIMbVYZxoeSt/0WhOdywrNFqy8o8TqPUgO8hr+qqH+yhlPxcb1Ruc6p2rsbJVBarqldAnAigNUTKZbXe3Q+36/+jjrwqQQa8ZJRhLhTZ566TaRMyTUbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709307933; c=relaxed/simple;
	bh=o7seXpq2OKFR9HNWbVZim1h7r3YFzrCborTntN7Wyrw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RmQ7LauIPWPi3qLZcfNc9t8y2tVNtEvn7kghduBErIeoM876FVdhLajNHJwnCGsoR3MBPTCp6V2tzRb9MYvI2pt/vmTbR2H+tixnyufi+xKg9DH3vf7eC4ECZJxHo7qqh1zG22+0l+fmgQLZj2b3xhWkP9j4+umobRd9TH/6d8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=njA5yHoq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sUUp3Ps2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=njA5yHoq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sUUp3Ps2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A5AE720698;
	Fri,  1 Mar 2024 15:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709307929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+1w0gLQ5VK0mzd/6Gme9HV9E0oLfgz10Sk8c+4u/9fI=;
	b=njA5yHoquNHCJ3KR1Wq23s6kUsQtyU1QFyrFd3Lk8RYzgyxHERSWXOPf+jnoiRazQwsdrR
	htA87yo8w8I+w/Fvf4KT8UMfXD8aOTbfnQZ0qchkNgPVmqkxip55K35R3w1p7Zqfq8K0Jz
	Ab1neGMlPX9Fp9BgNNv99AJt/xCm154=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709307929;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+1w0gLQ5VK0mzd/6Gme9HV9E0oLfgz10Sk8c+4u/9fI=;
	b=sUUp3Ps2GZU1zYwoFZ/yaXFODL6PKMu+S32hSWxSMkF0Uitx/BPB0ZVISV/jxbB5kYW3AC
	uvJ9f/hMRHUpeZBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709307929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+1w0gLQ5VK0mzd/6Gme9HV9E0oLfgz10Sk8c+4u/9fI=;
	b=njA5yHoquNHCJ3KR1Wq23s6kUsQtyU1QFyrFd3Lk8RYzgyxHERSWXOPf+jnoiRazQwsdrR
	htA87yo8w8I+w/Fvf4KT8UMfXD8aOTbfnQZ0qchkNgPVmqkxip55K35R3w1p7Zqfq8K0Jz
	Ab1neGMlPX9Fp9BgNNv99AJt/xCm154=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709307929;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+1w0gLQ5VK0mzd/6Gme9HV9E0oLfgz10Sk8c+4u/9fI=;
	b=sUUp3Ps2GZU1zYwoFZ/yaXFODL6PKMu+S32hSWxSMkF0Uitx/BPB0ZVISV/jxbB5kYW3AC
	uvJ9f/hMRHUpeZBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E566113A80;
	Fri,  1 Mar 2024 15:45:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id D93DNBj44WWSAwAAD6G6ig
	(envelope-from <lhenriques@suse.de>); Fri, 01 Mar 2024 15:45:28 +0000
Received: from localhost (brahms.olymp [local])
	by brahms.olymp (OpenSMTPD) with ESMTPA id a9503a18;
	Fri, 1 Mar 2024 15:45:28 +0000 (UTC)
From: Luis Henriques <lhenriques@suse.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>,  Andreas Dilger
 <adilger.kernel@dilger.ca>,  Alexander Viro <viro@zeniv.linux.org.uk>,
  Jan Kara <jack@suse.cz>,  Miklos Szeredi <miklos@szeredi.hu>,  Amir
 Goldstein <amir73il@gmail.com>,  linux-ext4@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  linux-unionfs@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] fs_parser: handle parameters that can be empty and
 don't have a value
In-Reply-To: <20240301-gegossen-seestern-683681ea75d1@brauner> (Christian
	Brauner's message of "Fri, 1 Mar 2024 14:31:49 +0100")
References: <20240229163011.16248-1-lhenriques@suse.de>
	<20240229163011.16248-2-lhenriques@suse.de>
	<20240301-gegossen-seestern-683681ea75d1@brauner>
Date: Fri, 01 Mar 2024 15:45:27 +0000
Message-ID: <87il269crs.fsf@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[4];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_LAST(0.00)[];
	 FREEMAIL_CC(0.00)[mit.edu,dilger.ca,zeniv.linux.org.uk,suse.cz,szeredi.hu,gmail.com,vger.kernel.org];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

Christian Brauner <brauner@kernel.org> writes:

> On Thu, Feb 29, 2024 at 04:30:08PM +0000, Luis Henriques wrote:
>> Currently, only parameters that have the fs_parameter_spec 'type' set to
>> NULL are handled as 'flag' types.  However, parameters that have the
>> 'fs_param_can_be_empty' flag set and their value is NULL should also be
>> handled as 'flag' type, as their type is set to 'fs_value_is_flag'.
>>=20
>> Signed-off-by: Luis Henriques <lhenriques@suse.de>
>> ---
>>  fs/fs_parser.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/fs/fs_parser.c b/fs/fs_parser.c
>> index edb3712dcfa5..53f6cb98a3e0 100644
>> --- a/fs/fs_parser.c
>> +++ b/fs/fs_parser.c
>> @@ -119,7 +119,8 @@ int __fs_parse(struct p_log *log,
>>  	/* Try to turn the type we were given into the type desired by the
>>  	 * parameter and give an error if we can't.
>>  	 */
>> -	if (is_flag(p)) {
>> +	if (is_flag(p) ||
>> +	    (!param->string && (p->flags & fs_param_can_be_empty))) {
>>  		if (param->type !=3D fs_value_is_flag)
>>  			return inval_plog(log, "Unexpected value for '%s'",
>>  				      param->key);
>
> If the parameter was derived from FSCONFIG_SET_STRING in fsconfig() then
> param->string is guaranteed to not be NULL. So really this is only
> about:
>
> FSCONFIG_SET_FD
> FSCONFIG_SET_BINARY
> FSCONFIG_SET_PATH
> FSCONFIG_SET_PATH_EMPTY
>
> and those values being used without a value. What filesystem does this?
> I don't see any.
>
> The tempting thing to do here is to to just remove fs_param_can_be_empty
> from every helper that isn't fs_param_is_string() until we actually have
> a filesystem that wants to use any of the above as flags. Will lose a
> lot of code that isn't currently used.

Right, I find it quite confusing and I may be fixing the issue in the
wrong place.  What I'm seeing with ext4 when I mount a filesystem using
the option '-o usrjquota' is that fs_parse() will get:

 * p->type is set to fs_param_is_string
   ('p' is a struct fs_parameter_spec, ->type is a function)
 * param->type is set to fs_value_is_flag
   ('param' is a struct fs_parameter, ->type is an enum)

This is because ext4 will use the __fsparam macro to set define a
fs_param_spec as a fs_param_is_string but will also set the
fs_param_can_be_empty; and the fsconfig() syscall will get that parameter
as a flag.  That's why param->string will be NULL in this case.

Cheers,
--=20
Lu=C3=ADs

