Return-Path: <linux-fsdevel+bounces-14127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9112687808B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 14:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4AD01C20A2D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 13:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE3F41211;
	Mon, 11 Mar 2024 13:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="v5kj+ak5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XDy1K3kw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gPFBFEt/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+81grTX6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041C344C94;
	Mon, 11 Mar 2024 13:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710163416; cv=none; b=N0r2dt5Av87GbURdtddyGaAlT4JB+8exMPj7Fe3o1bUzjR9SZwv85ZAXtFlqVXx5Axx65LJSkYtXgspvHa5ERDgZhnABf07lj8GvkXaeXWafNmU78k28NrI29TCNLPKXdH/61uuEXhCuIQpCWHHMTNuW3/j4A/TUXCHsjtAHHfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710163416; c=relaxed/simple;
	bh=brj7PcDebxzqy5h/4qUh9EuMYF6nl92kPq5iO4h0qlo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dKGFep3BKSMoEeQsciBH0XDl6i1p5t7E3T4h3pkHvbi7PDZxceFDoMU24fa1vdqgsSFayR6B6isk/Y9HQETDGw8TEzsQKeuPUGasuxpynFbvCqW+VHCB6AeaVBGIajE9KVXG5LTuvDtxAP42m2PI8L3ZmIFGiDOGeZfK0OOAuVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=v5kj+ak5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XDy1K3kw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gPFBFEt/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+81grTX6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1B5095C6F9;
	Mon, 11 Mar 2024 13:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710163412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CJbAerBqTbOOE1+wiI2WyrWukn4dJy5uIYJHUCts2AY=;
	b=v5kj+ak5ixoKhwkClCLxwWmQlsBerHX+GElP1+wVjkkTZwJ5DiQyEX79QIeg8xByZJTk2S
	r1Jn3x4O+piA8WeDQSURdSUMMGKahuBfIl5jO+aM1n64QQeWZ0cmy3NBpoDrFjW77/xFEW
	G5E1RPtFESZ9dleWttKaVxZeX0xB7x0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710163412;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CJbAerBqTbOOE1+wiI2WyrWukn4dJy5uIYJHUCts2AY=;
	b=XDy1K3kwBLDjAjRAqdufyorJpTP1CEScUh+3UhLZfLp45DGZAT360LfDiBMSw/COKxkFa1
	7bI7/iJgR9WxqOAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710163410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CJbAerBqTbOOE1+wiI2WyrWukn4dJy5uIYJHUCts2AY=;
	b=gPFBFEt/hhRUBNldPBe6CJkUyRAbwoNtDaTuoikTAtKSH7UTOHh2LIyyea01EwbrvBrgtR
	9rHt0UqLPm6HB7WUl+Kndn/t1+6WRVvaQtjgpW1Zu4fCoctEcn1Gj+oqe1UA7bRZHtASwo
	3H31eLj9QDP6bjr9cSRNHYSHuM44W8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710163410;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CJbAerBqTbOOE1+wiI2WyrWukn4dJy5uIYJHUCts2AY=;
	b=+81grTX6TA27Urm9RoHwlcpr4VPQeFv/2t4x24NL5id9ej1P7CGqVXNtcQwhky7UBUyRaB
	UPbWI/lNaLlXwnBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4FDD113695;
	Mon, 11 Mar 2024 13:23:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id d50qENEF72UxVgAAD6G6ig
	(envelope-from <lhenriques@suse.de>); Mon, 11 Mar 2024 13:23:29 +0000
Received: from localhost (brahms.olymp [local])
	by brahms.olymp (OpenSMTPD) with ESMTPA id 8b1d090d;
	Mon, 11 Mar 2024 13:23:25 +0000 (UTC)
From: Luis Henriques <lhenriques@suse.de>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: "Theodore Ts'o" <tytso@mit.edu>,  Andreas Dilger
 <adilger.kernel@dilger.ca>,  Alexander Viro <viro@zeniv.linux.org.uk>,
  Christian Brauner <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,  Amir
 Goldstein <amir73il@gmail.com>,  linux-ext4@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  linux-unionfs@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] ovl: fix the parsing of empty string mount
 parameters
In-Reply-To: <CAJfpeguN9nMJGJzx8sgwP=P9rJFVkYF5rVZOi_wNu7mj_jfBsA@mail.gmail.com>
	(Miklos Szeredi's message of "Mon, 11 Mar 2024 11:53:03 +0100")
References: <20240307160225.23841-1-lhenriques@suse.de>
	<20240307160225.23841-4-lhenriques@suse.de>
	<CAJfpegtQSi0GFzUEDqdeOAq7BN2KvDV8i3oBFvPOCKfJJOBd2g@mail.gmail.com>
	<87le6p6oqe.fsf@suse.de>
	<CAJfpeguN9nMJGJzx8sgwP=P9rJFVkYF5rVZOi_wNu7mj_jfBsA@mail.gmail.com>
Date: Mon, 11 Mar 2024 13:23:25 +0000
Message-ID: <87cys0x5pu.fsf@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 URIBL_BLOCKED(0.00)[suse.de:email,szeredi.hu:email];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[4];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[szeredi.hu:email,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_LAST(0.00)[];
	 FREEMAIL_CC(0.00)[mit.edu,dilger.ca,zeniv.linux.org.uk,kernel.org,suse.cz,gmail.com,vger.kernel.org];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -3.10
X-Spam-Flag: NO

Miklos Szeredi <miklos@szeredi.hu> writes:

> On Mon, 11 Mar 2024 at 11:34, Luis Henriques <lhenriques@suse.de> wrote:
>>
>> Miklos Szeredi <miklos@szeredi.hu> writes:
>>
>> > On Thu, 7 Mar 2024 at 19:17, Luis Henriques <lhenriques@suse.de> wrote:
>> >>
>> >> This patch fixes the usage of mount parameters that are defined as st=
rings
>> >> but which can be empty.  Currently, only 'lowerdir' parameter is in t=
his
>> >> situation for overlayfs.  But since userspace can pass it in as 'flag'
>> >> type (when it doesn't have a value), the parsing will fail because a
>> >> 'string' type is assumed.
>> >
>> > I don't really get why allowing a flag value instead of an empty
>> > string value is fixing anything.
>> >
>> > It just makes the API more liberal, but for what gain?
>>
>> The point is that userspace may be passing this parameter as a flag and
>> not as a string.  I came across this issue with ext4, by doing something
>> as simple as:
>>
>>     mount -t ext4 -o usrjquota=3D /dev/sda1 /mnt/
>>
>> (actually, the trigger was fstest ext4/053)
>>
>> The above mount should succeed.  But it fails because 'usrjquota' is set
>> to a 'flag' type, not 'string'.
>
> The above looks like a misparsing, since the equals sign clearly
> indicates that this is not a flag.

No, not really.  The same thing happens without the '=3D':

mount -t ext4 -o usrjquota /dev/loop0p1 /mnt/=20
mount: /mnt: wrong fs type, bad option, bad superblock on /dev/loop0p1, mis=
sing codepage or helper program, or other error.
       dmesg(1) may have more information after failed mount system call.

The parsing code gets a FSCONFIG_SET_FLAG instead of FSCONFIG_SET_STRING.

>> Note that I couldn't find a way to reproduce the same issue in overlayfs
>> with this 'lowerdir' parameter.  But looking at the code the issue is
>> similar.
>
> In overlayfs the empty lowerdir parameter has a special meaning when
> lowerdirs are appended instead of parsed in one go.   As such it won't
> be used from /etc/fstab for example, as that would just result in a
> failed mount.
>
> I don't see a reason to allow it as a flag for overlayfs, since that
> just add ambiguity to the API.

Fine with me.  But it'd be nice to double-check (by testing) that when
overlayfs gets a 'lowerdir' without a value it really is doing what you'd
expect it to do.

Cheers,
--=20
Lu=C3=ADs

