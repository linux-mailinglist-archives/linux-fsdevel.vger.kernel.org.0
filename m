Return-Path: <linux-fsdevel+bounces-59316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BBCB37386
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 21:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DEB67A3D41
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 19:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4240636CC76;
	Tue, 26 Aug 2025 19:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="JL/AEh6c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7538030CD8E;
	Tue, 26 Aug 2025 19:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756238315; cv=none; b=sgeKi2+b+XizC+4isPdIeybqHoEqmiqIdIFTUitDv9IjeCYjN1OjP4urQeeO0CSaBWlNYBZV556891r28+zgEZZ9m9QmbFr1xaBm8RAjnqQJOSudrQcGsjekuZ+bWDpRpkqK2DInRtQRv/SdxpyRG25+nYw3LlkcJp368+Uw44E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756238315; c=relaxed/simple;
	bh=sQh6Hh7nM2R2AVB+kg0sRGcg38xkWEp8B797I+e4X24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fb5jW0/SLqAwlIketqdWuNJ3wpivjz0f1DJqtibe0Cm9P9R7pqXo1X0CRObUskocredoA2Gz+BtTpVR4A32iF9fWNJ7DXaX4A8tKwstS801NgAztfz1UU7CdoGLXdUmRer58p2apu/G5z8n20pOQEC7kEjCM4zhcIsuMaWFGXPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=JL/AEh6c; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=b/ZWldiU09DokIkc8tpE0h2CzKr2MQIEwFmULf+sPa8=; b=JL/AEh6cHl1P6P4FLnUCbOjfPi
	VOBvon4hgz3Gwvzmvhte+M3IIGt0jECS/fM/kUxo2SjGOLzzcsaF4bHf0Qg7yNGcUalwzT0FeZYM9
	t/TzNAJd+nb10jEEe8B8+8T36F2Jgx3x7yOOjmjD+51/l6hKVkQyytOvsSNp7idbkHcs4c7OOuPHy
	hC733Rme8cLp2Kvn0JePkCMJFJOw3vZCLPbZHC7ePxRBAGWtIlGtACZhBCXlexr3GZrqNAdkJWpRk
	g5o4JxOBWi7QIexyRIp1XD9opoSEEIBKr2Z1qfIwaj/9AadLIP+TF5M2plQhCOndrQTv63GVfu5Tq
	lxTAZikQ==;
Received: from [187.57.78.222] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uqzoH-00250Q-Cz; Tue, 26 Aug 2025 21:58:25 +0200
Message-ID: <564e46ac-a605-4b20-bb48-444bf7141ab5@igalia.com>
Date: Tue, 26 Aug 2025 16:58:20 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/9] ovl: Create ovl_casefold() to support casefolded
 strncmp()
To: Gabriel Krisman Bertazi <krisman@suse.de>,
 Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>,
 linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 kernel-dev@igalia.com
References: <20250822-tonyk-overlayfs-v6-0-8b6e9e604fa2@igalia.com>
 <20250822-tonyk-overlayfs-v6-4-8b6e9e604fa2@igalia.com>
 <875xeb64ks.fsf@mailhost.krisman.be>
 <CAOQ4uxiHQx=_d_22RBUvr9FSbtF-+DJMnoRi0QnODXRR=c47gA@mail.gmail.com>
 <CAOQ4uxgaefXzkjpHgjL0AZrOn_ZMP=b1TKp-KDh53q-4borUZw@mail.gmail.com>
 <871poz4983.fsf@mailhost.krisman.be> <87plci3lxw.fsf@mailhost.krisman.be>
 <CAOQ4uxhw26Tf6LMP1fkH=bTD_LXEkUJ1soWwW+BrgoePsuzVww@mail.gmail.com>
 <87ldn62kjy.fsf@mailhost.krisman.be>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <87ldn62kjy.fsf@mailhost.krisman.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Em 26/08/2025 12:02, Gabriel Krisman Bertazi escreveu:
> Amir Goldstein <amir73il@gmail.com> writes:
> 
>> On Tue, Aug 26, 2025 at 3:34 AM Gabriel Krisman Bertazi <krisman@suse.de> wrote:
>>
>>>
>>> I was thinking again about this and I suspect I misunderstood your
>>> question.  let me try to answer it again:
>>>
>>> Ext4, f2fs and tmpfs all allow invalid utf8-encoded strings in a
>>> casefolded directory when running on non-strict-mode.  They are treated
>>> as non-encoded byte-sequences, as if they were seen on a case-Sensitive
>>> directory.  They can't collide with other filenames because they
>>> basically "fold" to themselves.
>>>
>>> Now I suspect there is another problem with this series: I don't see how
>>> it implements the semantics of strict mode.  What happens if upper and
>>> lower are in strict mode (which is valid, same encoding_flags) but there
>>> is an invalid name in the lower?  overlayfs should reject the dentry,
>>> because any attempt to create it to the upper will fail.
>>
>> Ok, so IIUC, one issue is that return value from ovl_casefold() should be
>> conditional to the sb encoding_flags, which was inherited from the
>> layers.
> 
> yes, unless you reject mounting strict_mode filesystems, which the best
> course of action, in my opinion.
> 
>>
>> Again, *IF* I understand correctly, then strict mode ext4 will not allow
>> creating an invalid-encoded name, but will strict mode ext4 allow
>> it as a valid lookup result?
> 
> strict mode ext4 will not allow creating an invalid-encoded name. And
> even lookups will fail.  Because the kernel can't casefold it, it will
> assume the dirent is broken and ignore it during lookup.
> 
> (I just noticed the dirent is ignored and the error is not propagated in
> ext4_match.  That needs improvement.).
> 
>>>
>>> André, did you consider this scenario?
>>
>> In general, as I have told Andre from v1, please stick to the most common
>> configs that people actually need.
>>
>> We do NOT need to support every possible combination of layers configurations.
>>
>> This is why we went with supporting all-or-nothing configs for casefolder dirs.
>> Because it is simpler for overlayfs semantics and good enough for what
>> users need.
>>
>> So my question is to you both: do users actually use strict mode for
>> wine and such?
>> Because if they don't I would rather support the default mode only
>> (enforced on mount)
>> and add support for strict mode later per actual users demand.
> 
> I doubt we care.  strict mode is a restricted version of casefolding
> support with minor advantages.  Basically, with it, you can trust that
> if you update the unicode version, there won't be any behavior change in
> casefolding due to newly assigned code-points.  For Wine, that is
> irrelevant.
> 
> You can very well reject strict mode and be done with it.
> 

Amir,

I think this can be done at ovl_get_layers(), something like:

if (sb_has_strict_encoding(sb)) {
	pr_err("strict encoding not supported\n");
	return -EINVAL;
}


