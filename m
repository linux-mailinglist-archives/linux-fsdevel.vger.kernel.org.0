Return-Path: <linux-fsdevel+bounces-26719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 820B795B536
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 14:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E372285CD3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 12:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5819E1C93B7;
	Thu, 22 Aug 2024 12:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="FTeTHpu1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2292146A6E
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 12:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724330512; cv=none; b=m4DxDbBn+eyDorNhSk6zMRfuvUU8j2J7TOfsnSWZtkF60N2rbeJbioIOrHDgY0A/qqaVgQKeZpKOevjNcUCWMTkNZhJ4k69XjIEsNduGBCv9ZVTelVxNmXT3aUKfFjZszm5z5Lii6P47VvdQ+X9fwzmdhM8IaSQUenNSjGg96qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724330512; c=relaxed/simple;
	bh=YamrHcq1fJsh2YevvhwP+/0hV/vKFWnL2zIQA9uS5Lw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TcTk7SWSAp0cZI9rwNz5F16D/uEem4ZDwmwcCHfhh2aKdpwOer7bsBJgDCrYhACBzBAR2jLJkngK6/awO1crJnmTv1E6gWSmJtAVigmv+qwtBsH70TNwa85pBNsqN8H4tJSgNYagQG467jsuF4Exiq6iLzNWv1kY8yBhDhUDjFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=FTeTHpu1; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a83597ce5beso118765966b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 05:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724330509; x=1724935309; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CRAULOVKdMFPQlqD1ShnCj+B1fwC9jiPX9rgoEdC20E=;
        b=FTeTHpu1aBVSL0LZ1eGwluy0r0j2U9AhOlxNZ1etZKe/vgdoPbpX93cpBA8hkPkgYx
         dag9VC6otm11Vx9XzVHdnFTfo9nyxAvITKwMRPKFG6sCvBhYe4BXNTvr9TPimDNa/9WV
         CTZK4/VT5usmt23cSmERE6fb1AShFn9zT99f0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724330509; x=1724935309;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CRAULOVKdMFPQlqD1ShnCj+B1fwC9jiPX9rgoEdC20E=;
        b=li/e3alYddbsl0XUwAaYGCP3KTBim4XcQv+ie96STc1ZjlZcfCVbt/D6Vq5QcQRqRi
         8IwW0no0DTxBJZxeLOOyeKz/v332pVV1hirvJy/BA0qdQJrcoFQR3pSnjUTPmU+9ALZ2
         NtaBMHfqSC6yYWDoVbMgk5e8W4lg7MZSSe87PqZpylZ+PYW2Rk5N94XEDjaEntdlmx0j
         BLxPSehdZrcngWq7sWSRu/y1JLdqVS5N16TW7v61Vni6gR42fXVNY/oVwQalk3Q0oQxi
         POnmBIiZN3STTfv9uN6L6vL67e/QuXtD1WXhf5K4gYiefCPr5IEzt8Vb5L8RnyqiydSR
         z4MQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1/6wlblJXGsRRXbQlJ3oHyDJCXXyD/LDXHd0JVELKeNN83RzaOdDkMgU6/4fqqQl4YO4kSHGGKxTjJUlM@vger.kernel.org
X-Gm-Message-State: AOJu0YzKr7l4jXQkfOWE0hW5PMnivtqjeMKX9zulylbF1hfMbJAI+cNt
	mb44BPfi4JCKGby/WcUxkZLwp1NcSi3LKYm/Edt5oD4gVG7g7EAuh6MmY0CRrEA4bB4PLJLmmJW
	8IgFx0e2MjrsyFeq6M/fngxtVoTsuiaSNDYDNyA==
X-Google-Smtp-Source: AGHT+IFRf4G/UzKDoWG6GBWkYhwBFK2qNeRLcjsaRtUAtY7cvWx/66cDwYkdQ4gzNwNFia/UfS/ijjrreD8QBUzfF+g=
X-Received: by 2002:a17:906:3c15:b0:a86:9bb1:56d9 with SMTP id
 a640c23a62f3a-a869bb157aamr31547366b.11.1724330508972; Thu, 22 Aug 2024
 05:41:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <GV0P278MB07187F9B0E7B576AD0B362B485802@GV0P278MB0718.CHEP278.PROD.OUTLOOK.COM>
In-Reply-To: <GV0P278MB07187F9B0E7B576AD0B362B485802@GV0P278MB0718.CHEP278.PROD.OUTLOOK.COM>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 22 Aug 2024 14:41:37 +0200
Message-ID: <CAJfpeguN0Hjwny0-mvTSJsBagYkTYx6OuP8Exs8b-WqpKt7VRw@mail.gmail.com>
Subject: Re: [fuse-devel] Symlink caching: Updating the target can result in
 corrupted symlinks - kernel issue?
To: Laura Promberger <laura.promberger@cern.ch>
Cc: "fuse-devel@lists.sourceforge.net" <fuse-devel@lists.sourceforge.net>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Aug 2024 at 16:45, Laura Promberger <laura.promberger@cern.ch> wrote:

>    08/15/24 11:35:36.086579 fuse_change_attributes:  func corrupt_symlink \
>                                                       inode: ino 270, size 22, version.counter 0, state 0 \
>                                                       fuse_attr: ino 270, size 16, blksize 4096, \
>                                                       fuse_statx: ino 0, size 0, blksize 0, \
>                                                       fuse_inode: ino 0, orig_ino 0, attr_version 0 state 0 \
>                                                       attr_valid 98, attr_version 0

Something's wrong with the debug output since attr_valid should be a
large number (current jiffies + timeout).

Thanks,
Miklos

