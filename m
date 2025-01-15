Return-Path: <linux-fsdevel+bounces-39313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDEAA1292F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 17:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BEB216474A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 16:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8195A1632FB;
	Wed, 15 Jan 2025 16:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jVvod8+J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9AE5473C
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2025 16:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736959948; cv=none; b=TOO0ARAvVe4yKhGGXUrYhBEHV30xU3YkmpgfgrNKNR7aLVbTtcsD+W4Kp0QEF3L00SXSKYmEnnZSgQ3Lyh6tFHtJs4E8i1EaXHQo0huZNiqn6XvCT133WOOvbiAOAVbV36/yNdA+TkpF83+bhGBXVBS/+wJPALU/3lqZ7lI/gBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736959948; c=relaxed/simple;
	bh=zLWLVQk4r2AmkVEbsdzM+ykKIr2+jt4sgudbugXMaJA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HXXJu9cOmkSaOtpj927RhRHQN9arXsN3N1dwbHa9gwp/c/QGVikGmKwuDeGqfD2QBdj9eAzGOsNwTGl4RGnUAtRhDRpoanGfu6ln4M4CZgEdBknoQ1YuXF+UbQymIdSSAk+XfGf4l+1MIQmuWbSLPtL1WNtxu800X+zSv/WdK5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jVvod8+J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736959945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eh5wDdkBWRJdaptAT9mrjCTktpvvPlTQKiy87cXSTQc=;
	b=jVvod8+J02CkRb+t+W+XiJdI5gr/sbk6MJHk4vxG7y8x2dAZpM5akcsBhE+ABCbEZuKfMG
	XYusl71N8/8bzcqptTpcg8ucUvHQQ+5c1a+dIjGudkvm94FJ1ZR84FJ3k5giAZnKpjlpl/
	cisVwyp7DezkfEGwDj/OMdfvEPecFik=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-DRX9TdqjPSOuFZD3Js-HzQ-1; Wed, 15 Jan 2025 11:52:23 -0500
X-MC-Unique: DRX9TdqjPSOuFZD3Js-HzQ-1
X-Mimecast-MFC-AGG-ID: DRX9TdqjPSOuFZD3Js-HzQ
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3cde3591dbfso294605ab.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2025 08:52:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736959943; x=1737564743;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eh5wDdkBWRJdaptAT9mrjCTktpvvPlTQKiy87cXSTQc=;
        b=jRseb+AJf75DA+vBQ9oeSeG1IRzC+4GSf/bu14PHRgiyRjWeyDotdeYULGR/8TA2SY
         nr5iE1cimy+wDLB/cCFpk+BhT8FkWq8yzGza9BfiWYveB49I7Pqp6TiTshceOTrOyI5R
         6L4DEiX31jCYWqv/xEKGUpFyNKeEiAVpPtA1SmaScAYt6upPsc1uCeDQj88AS6EDw7IE
         Mb0yFZ6+05w8wPMX+m8PGJ/7SmIWSizbsQxgkOA16aGMjwb8+JVMj2aJfF/mz6AOJm4r
         SitdLuvMsbejsVgXFHuVPRkhOcYtDUt8jiIDlyJgPjL6xuvmqerHseZlwyc6WogKdVXv
         ANyg==
X-Gm-Message-State: AOJu0YzYVMVOjt0ucsbjiy0M0lHVYEm86OAcYzeYi0HqjEO6IL4sBjm9
	Q1ydYeErSvT1V0uIs2NECEkMsmuLyDu59Zu6be1yaeSH5g20gRJAm7T2MH3oz0AiBauqDzEFE5R
	3+ck/wxk+bqjHmeXeOXfREKrB5gQVVvKBHepGo76dXGnexKudFdiT0l8vVtsDeKQmZQlA927w1O
	KiVPXb20DvDfFWrMf8EbiwTK7fVAhxFfum0Qu4irLxKrRYJ3AL
X-Gm-Gg: ASbGncsXT2ZhmK3aLH5j9DBairqzlB4VnvLlGXz1M9HdY0v5jFfAhaerf2WrN/aYqsW
	cNcjINVYLMgguFaZxxQQB3c7wRvh9p00qpgaKnFTTaJzXTs4GWEschuVknc2difIEowKCVe8h5l
	L5H66jCJj5oKKo4zLyguR+YvJB5b6G+Q6G5b38qBhfZksTDWD4Ocjr0s7Jk2c9XVHgaoIvog1KG
	+vm6/cfOKY2B6DX9OJwZXLkS9GFbRc0yz9RLqEV6v7/Bk9d0Eq8qHuZJzmo8yEeal4BAwpH9iK4
	NjYBZgmI5VhqDACvI8DL
X-Received: by 2002:a05:6e02:6cf:b0:3ce:7c7d:37b3 with SMTP id e9e14a558f8ab-3ce84a62d72mr28539735ab.9.1736959943008;
        Wed, 15 Jan 2025 08:52:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjW2JxlZJoE9PC75UvgzonqZMwUWmqVKtu+byd24Hm67z3Y6TcryfuBI8K76PbQ+xXzJaDxA==
X-Received: by 2002:a05:6e02:6cf:b0:3ce:7c7d:37b3 with SMTP id e9e14a558f8ab-3ce84a62d72mr28539305ab.9.1736959942236;
        Wed, 15 Jan 2025 08:52:22 -0800 (PST)
Received: from [10.0.0.48] (97-116-180-154.mpls.qwest.net. [97.116.180.154])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ce4af5612asm40511545ab.62.2025.01.15.08.52.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 08:52:21 -0800 (PST)
Message-ID: <655a759a-5d85-4384-8ba0-e444c53a7304@redhat.com>
Date: Wed, 15 Jan 2025 10:52:21 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mount api: Q on behavior of mount_single vs. get_tree_single
From: Eric Sandeen <sandeen@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
References: <732c3de1-ef0b-49a9-b2c2-0c3c5e718a40@redhat.com>
Content-Language: en-US
In-Reply-To: <732c3de1-ef0b-49a9-b2c2-0c3c5e718a40@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

(ugh, curse auto complete on addresses, cc: fixed sorry.)

On 1/15/25 10:50 AM, Eric Sandeen wrote:
> I was finally getting back to some more mount API conversions,
> and was looking at pstore, which I thought would be straightforward.
> 
> I noticed that mount options weren't being accepted, and I'm fairly
> sure that this is because there's some internal or hidden mount of
> pstore, and mount is actually a remount due to it using a single
> superblock. (looks like it was some sort of clone mount done under
> the covers by various processes, still not sure.)
> 
> In any case, that led me to wonder:
> 
> Should get_tree_single() be doing an explicit reconfigure like
> mount_single does?
> 
> mount_single() {
> ...
>         if (!s->s_root) {
>                 error = fill_super(s, data, flags & SB_SILENT ? 1 : 0);
>                 if (!error)
>                         s->s_flags |= SB_ACTIVE;
>         } else {
>                 error = reconfigure_single(s, flags, data);
>         }
> ...
> 
> My pstore problem abovec reminded me of the recent issue with tracefs
> after the mount api conversion, fixed with:
> 
> e4d32142d1de tracing: Fix tracefs mount options
> 
> and discussed at:
> 
> https://lore.kernel.org/lkml/20241030171928.4168869-2-kaleshsingh@google.com/
> 
> which in turn reminded me of:
> 
> a6097180d884 devtmpfs regression fix: reconfigure on each mount
> 
> so we've seen this difference in behavior with get_tree_single twice already,
> and then I ran into it again on pstore.
> 
> Should get_tree_single() callers be fixing this up themselves ala devtmpfs
> and tracefs, or should get_tree_single() be handling this internally?
> 
> Right now in my pstore patch I'm doing:
> 
> static int pstore_get_tree(struct fs_context *fc)
> {
>        if (fc->root)
>                return pstore_reconfigure(fc);
> 
>        return get_tree_single(fc, pstore_fill_super);
> }
> 
> but it really feels like this should be handled by core code instead.
> 
> Thoughts?
> 
> Thanks,
> -Eric
> 
> 


