Return-Path: <linux-fsdevel+bounces-58042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A6FB28472
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 18:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58973B02768
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 16:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD741F582A;
	Fri, 15 Aug 2025 16:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="EDTw/tA+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4567B257833;
	Fri, 15 Aug 2025 16:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276812; cv=none; b=RqPF6Mw86gaiVBwBGZKHP2aahwktGgue5dmkMC38RS7jT3dOD9CXpt5u0Oov+JUYNYg1A3fQA3czStc8QYbQ9L80CdalELCOy4+ppQN7hTtgn30Dn4tReCBrg6BN95rnrGLG4l0dkPeszkdSrmxJbM7vN9hKJOrTEh+f54fJ4cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276812; c=relaxed/simple;
	bh=IJTauwcjeaLB7Rg2YHZHDlfPxUCgpS/CVyoOTeRQ+MM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gOCmkxXiWTKqV/6eSdpTJ5gjU5fJpOx0B+vkn0TUKxnA+X2hUF0Qr/oRVqAt+4bCfemmIm1mo86DfHx0FzJjU5SNyKUsiJidVP6TYxbgpJjNny36LrKL3g4g7F5+QxAsHfASTnyN4JwsnhGXGTVg+IztPZ0rSTprzs9Jms89M2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=EDTw/tA+; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jzcEwcp/agY35uRuFzGVqIQxS9j8CtVFq7sL1wEGuBA=; b=EDTw/tA+mxWIJtinpkRc5cLFRn
	VkylWb0kL8uAnkTUk6ct1L78o3qxs7TCXHwtfwxwRBowOyQQbTGjtOCBrfk1VIZCuJBVaTDZL9m01
	JLpK7DMkn4hG8Wndb6gqSexlKfmBEml/iZNVHhrufPZ4DDO2rWETrIF/Zw6ZKh6sgHISb2RjbYwLd
	cMO3uOcv4/zoochx6Bi1YDupUoE+6kn7CgMOpoI5H5JKvAoSb9oBztFhptnNpTCuyVPNUqebd78kw
	7UBHMLgfnh9r7xhSg6KITXVccuUxFsw/lrs169WFOb7moGh7+Hd40LWKyD1xGpdJnp9Br32d4Qpu9
	ooLIRoUg==;
Received: from [177.191.196.76] (helo=[192.168.0.154])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1umxg7-00EjVd-G4; Fri, 15 Aug 2025 18:53:19 +0200
Message-ID: <2fad5988-b78f-4d48-943a-ec791ce38fb7@igalia.com>
Date: Fri, 15 Aug 2025 13:53:13 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/9] ovl: Create ovl_casefold() to support casefolded
 strncmp()
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>,
 Gabriel Krisman Bertazi <krisman@kernel.org>, linux-unionfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 kernel-dev@igalia.com
References: <20250814-tonyk-overlayfs-v5-0-c5b80a909cbd@igalia.com>
 <20250814-tonyk-overlayfs-v5-4-c5b80a909cbd@igalia.com>
 <CAOQ4uxjVs4kKfvfp+Jgdf2BxMW8v5p0gPHujRfCHj4733ioCag@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <CAOQ4uxjVs4kKfvfp+Jgdf2BxMW8v5p0gPHujRfCHj4733ioCag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/15/25 13:16, Amir Goldstein wrote:
> On Thu, Aug 14, 2025 at 7:22 PM André Almeida <andrealmeid@igalia.com> wrote:
>> To add overlayfs support casefold layers, create a new function
>> ovl_casefold(), to be able to do case-insensitive strncmp().
>>
>> ovl_casefold() allocates a new buffer and stores the casefolded version
>> of the string on it. If the allocation or the casefold operation fails,
>> fallback to use the original string.
>>
>> The case-insentive name is then used in the rb-tree search/insertion
>> operation. If the name is found in the rb-tree, the name can be
>> discarded and the buffer is freed. If the name isn't found, it's then
>> stored at struct ovl_cache_entry to be used later.
>>
>> Signed-off-by: André Almeida <andrealmeid@igalia.com>

[...]

>> @@ -260,12 +305,38 @@ static bool ovl_fill_merge(struct dir_context *ctx, const char *name,
>>   {
>>          struct ovl_readdir_data *rdd =
>>                  container_of(ctx, struct ovl_readdir_data, ctx);
>> +       struct ovl_fs *ofs = OVL_FS(rdd->dentry->d_sb);
>> +       char *cf_name = NULL;
>> +       int c_len = 0;
>> +       int ret;
>> +
>> +       const char *c_name = NULL;
>> +
> Another nit:
> Pls move up next to cf_name = NULL line in your branch
>
> No need to repost.

Done. Also joined int ret and int c_len to the same declaration;

>
> Thanks,
> Amir.

