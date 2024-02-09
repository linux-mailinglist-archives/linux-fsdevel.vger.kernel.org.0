Return-Path: <linux-fsdevel+bounces-10934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D814984F49A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 12:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7394E1F2BCC9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 11:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D5A33CE9;
	Fri,  9 Feb 2024 11:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="xkKwMAYP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rEy/Awqc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED93433CCF
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 11:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707478006; cv=none; b=C5F9LLTbnsKf6wFoiTlvYOUyIxkVP1pwFgmkBmu4YBNx6B802w+pSwBJgPXS9F4YSP0kxup1dvnY2NyxHA6lb9lUU2ruYT2ZR31RCSOR6R1r5v9Nq2z5f4YM5+ejPT9qibEwvWXZHXl6nRVyIljjRfTc7v7kTtTsdV+N9uP5FSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707478006; c=relaxed/simple;
	bh=g525TUTDMPJF511PiRKjzz7/1DZqcrY1HBJ0EZGnNEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pj062cG2gAXNajjvs5pI7yhlR4XKu7Cp3oQ6EjegMVtWzTTFkaMC3vrJE026MlKCjT8Y8BdRRoS5S3Kfk6DIJguSPUfrkv25GsDtBVaPibY/VjodEHjEKX3jOexpVGOiIIjm4VvYBpp6zbwbznXqMrmHMu20/kjGgJ3xLUswjxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=xkKwMAYP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rEy/Awqc; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id CEFB33200A2D;
	Fri,  9 Feb 2024 06:26:43 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 09 Feb 2024 06:26:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1707478003;
	 x=1707564403; bh=CWYqDmfiHRfhrBaC3iXXjmn+r6w4qM3zqoVoh4dQ1cI=; b=
	xkKwMAYPsbloMBwC5hfS0coGa1+oUK5G999d0MoFcCGv6TFrPAa2+hP2J0/jOQDB
	qy+rzo1UIZkE/MF6BTSExKXPQkXu/PreFFEU5ZpY1T5PFBu3dgZGhQxqU3YqIcVS
	CkJGo/bQQ/mlr0C04L6Rd3TFo0/4zl3Dv1Ish4kimqKomXUsVzjRuYHrRjikPQOd
	V4qfD6Ve6p9agHhSA3V7Yt33IcygJgu2LVJ+4oPkvkUW1lMsATQloWcYr8i3Ad0i
	p0Lfity9RKUV3+V3y+P9A4mukeeMByzMsOMYvRaD8jGQ+v8hULLGaH+0k1/OgIQK
	mIHncYhzCa8lsU/hyHeipQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707478003; x=
	1707564403; bh=CWYqDmfiHRfhrBaC3iXXjmn+r6w4qM3zqoVoh4dQ1cI=; b=r
	Ey/AwqcNYndX/S0FgK5HFVeX3lNEHVa6ld0V2+Z5eFNeYaakTk9yZvpvoKaT2h4c
	dHWhqbX/b/vAFrjMO3qmB6cJFAi4hfsHZtlMMlDO3L7mwbxByxk+pAu4dmWM1JtK
	LJE+fPBKkZMq2zybwYL6+QBBdyIILryXW6v0N53QUVYw+h7QFcn6t+dqnc2VHwF6
	Svr/GCEkZms8PLFFpdT+9bIyaDbjAsqWkHh5ZSqFDJTJ69kMPs6RARMJMIhdXBMa
	CaI04x9dQyI4dAON602QEv7avtvuHYHOv7AcURCGg7Mv/9QMrA23BqNy4lJFcCes
	JnKfcwGar+CjHwwkXs9/g==
X-ME-Sender: <xms:8wvGZXszlrFRtmwWUvsuA6h-mnMDjyMk65nAf-AeYEsBKh2BHY8TyA>
    <xme:8wvGZYeJjvZ1MxsOsDaRtNjHv2KO7HfrYwbfPViqaj1-oqQ5LsytOgod59yvqJ_HA
    pty3QG5Jyx9Jjzv>
X-ME-Received: <xmr:8wvGZawwFNyW1aJmK7uUmIFXxUnENVGYFbP49gg0vNhtVaWWOm2WYE1Uwjoq9LYX3i4fFKKWmoSXLGk1UFhmCYi3Y79Ni9tXhB3b27XURaEBnMezvXN7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdeigddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeevhffgvdeltddugfdtgfegleefvdehfeeiveej
    ieefveeiteeggffggfeulefgjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhf
    mh
X-ME-Proxy: <xmx:8wvGZWOtxiMil6lIfbaop5f0tc5zs_4Jm4XbBz-QI9kOErEJ43hIsw>
    <xmx:8wvGZX-J5qif5ALRnV8ojmmXnsHkyaWn2UbW9stSrSESb2l39cShaA>
    <xmx:8wvGZWVBq22iYnxHaJZR3l8RcJmcrmFav6oa1SQyqVq2sxpxBC9W4Q>
    <xmx:8wvGZRni8qn1TB7Sf6nYqG-uRDLi2GMb5vX4-g0wDYhSwagzbUFsvg>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Feb 2024 06:26:42 -0500 (EST)
Message-ID: <ca40f854-6943-472f-94f9-2bceb50a11db@fastmail.fm>
Date: Fri, 9 Feb 2024 12:26:41 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/9] fuse: allocate ff->release_args only if release is
 needed
Content-Language: en-US, de-DE, fr
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
References: <20240208170603.2078871-1-amir73il@gmail.com>
 <20240208170603.2078871-6-amir73il@gmail.com>
 <CAJfpegs4O1mXJUeWfQmT+B2X9xoXp9r8HoYLV_627WLpF+s64Q@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAJfpegs4O1mXJUeWfQmT+B2X9xoXp9r8HoYLV_627WLpF+s64Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/9/24 10:57, Miklos Szeredi wrote:
> On Thu, 8 Feb 2024 at 18:09, Amir Goldstein <amir73il@gmail.com> wrote:
> 
>> @@ -132,15 +134,16 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
>>         struct fuse_conn *fc = fm->fc;
>>         struct fuse_file *ff;
>>         int opcode = isdir ? FUSE_OPENDIR : FUSE_OPEN;
>> +       int noopen = isdir ? fc->no_opendir : fc->no_open;
> 
> bool?
> 
>>
>> -       ff = fuse_file_alloc(fm);
>> +       ff = fuse_file_alloc(fm, !noopen);
>>         if (!ff)
>>                 return ERR_PTR(-ENOMEM);
>>
>>         ff->fh = 0;
>>         /* Default for no-open */
>>         ff->open_flags = FOPEN_KEEP_CACHE | (isdir ? FOPEN_CACHE_DIR : 0);
>> -       if (isdir ? !fc->no_opendir : !fc->no_open) {
>> +       if (!noopen) {
> 
> I think this would be more readable without the double negation, i.e
> if the bool variable was called e.g. "open".

We can change to bool. I had _thought_ to suggest in the internal review
round to use

bool is_open = isdir ? !fc->no_opendir : !fc->no_open;

But then we have double negations in the initialization and for me it
didn't seem to be much better than having them below (though two times
then). I guess no issue if you prefer like that.


Thanks,
Bernd


