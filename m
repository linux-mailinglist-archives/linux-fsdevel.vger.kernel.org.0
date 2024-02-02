Return-Path: <linux-fsdevel+bounces-10020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E55D98470F8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 14:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96CD328C2E6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 13:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB5A32C88;
	Fri,  2 Feb 2024 13:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="X9zvSy8U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB3F1773D
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 13:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706879889; cv=none; b=bvp89EKSvyRa5a8WysedxfUsV1t9fecjq3wL2zoOKw2vKu4Y5oaBUzYv7xI0EzNxIyEtqR4Sozr79HI79gUmKmujBLk+gNJzMCaDWq0lGoqe2i4SwlE2bNS0+MaHnyOaivCs+3F3FvbVE7dqhNPaHq/cj8vsWIQqGQk/nZuPpU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706879889; c=relaxed/simple;
	bh=TVEt2jHtHb61K1i6et+msFxYPgYsZ2I/trn8BkT7X2E=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Jjoo0gIuqb6zEImBaKste65HLcxp1m4e5gIpO5fDgR7YS3NaXXDtQVtish0CkS20e8WZqRPgS0b51nonsnqJfKYiYRg5PdnFk+QKXBxLhROISxakKubNLBPffw7tHfO6HzuMhVM/RyxTMJS6tcX5WSBXc6ZH88F4jSJpr8hOPQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=X9zvSy8U; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-511234430a4so3500885e87.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Feb 2024 05:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1706879885; x=1707484685; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVEt2jHtHb61K1i6et+msFxYPgYsZ2I/trn8BkT7X2E=;
        b=X9zvSy8UrCadnt6n/JB/nDhTibJk0Ij3LkTZZkIXE7ombbI/X/iIWo258XPS0nFy2R
         qc2kAqzBVlZNyIvhIRvUDZmlP/S1YyYmIBVFB3+PjG5qWjfsg4gv3eDF8mtd2lTkurwB
         huDmp0SwFUvrE9GXcvmfWMF99pBVYifgWQNAGvXkD66ed8kWgdg7Kv8Nu6jqKuEpzFlg
         vvOvRQ9jaBAU9vAXBH5jr/liiPkFWs/drJHeoaU5E+jbr6CIBHCpUIZauJ4a1QkUr7Mu
         pN8UcZJOPEOcQFZb2bfjMNn/Fe5cQGJIeY8k4/lvEmc1rTjRXTh1/aT7X0VTUVu3l1JF
         nS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706879885; x=1707484685;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TVEt2jHtHb61K1i6et+msFxYPgYsZ2I/trn8BkT7X2E=;
        b=Om6kv+rBsmpsD4do76xJZwe90b9NOEfEDlqeCyPSCsdYzhE5hQPhBEsBT5gJAdycTO
         TaDd+qTJTJga8P4kssgHl3eEt0DAjU2MwSVDhAFW+c0E5hjLteMNlmMSR4GhvzSjrEfC
         bXwEoIwRlguryToq8CFM4OTDzmBAL3ZHOCQzMFtbhnpjAFK3LMOlZc6RHeC7ywcocKiw
         nFryAcEl1hPK78ctPEgT26KZxB4MBS9syl2IYqz9IDpAaKtRUtT86Yqi/gzM+t4xhuZi
         tCp8jclrCzwv6bfISI9P/mDbYjWLTmpYItdl/xqCTN1y6IzheDgdX5PAnOKjOkxymzD9
         +M/g==
X-Gm-Message-State: AOJu0Yz5OyzhB78Cy6CUqXEKXn9p7TWOGsLxjbjnjZCCCuFx5tgF1RZ4
	qLN5dbSZH+fXO8XLBq2Yqct/u/51IjeXBEI1A7NeRes6n7vRKmCX41/WvqBUX9E=
X-Google-Smtp-Source: AGHT+IE0lIO4yK60ZwridvY2MEnGVTaem9HWFCVDtVBepwgBkCdD8VOr2e2X2NFfruuUafQSbGl9UA==
X-Received: by 2002:a05:6512:3b90:b0:511:3b5c:c923 with SMTP id g16-20020a0565123b9000b005113b5cc923mr349188lfv.0.1706879885003;
        Fri, 02 Feb 2024 05:18:05 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUN7FYSXAnWO/n8VrUy/afhCK2ZUXPFxIE80ljlumLt8xuxRlW8wXI0ENzbmNyKKoXdUmChhC1hAzoLpNVsIieoKQyHNGtvEymERFG8deVN5uNQf05U7TxZvt8hSoaa9SJ+d0Y8iFXFtoqD83JXtzcRCt1/5m3tlxJqwCuDFejT9C/QfN1kng==
Received: from smtpclient.apple ([84.252.147.250])
        by smtp.gmail.com with ESMTPSA id c18-20020a056512325200b00510133ea456sm302476lfr.277.2024.02.02.05.18.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Feb 2024 05:18:04 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH] [v2] hfs: fix a memleak in hfs_find_init
From: Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <20240201130027.3058006-1-alexious@zju.edu.cn>
Date: Fri, 2 Feb 2024 16:17:49 +0300
Cc: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <464B735B-EE9E-4AAC-8AA5-B746D707D69B@dubeyko.com>
References: <20240201130027.3058006-1-alexious@zju.edu.cn>
To: Zhipeng Lu <alexious@zju.edu.cn>
X-Mailer: Apple Mail (2.3774.400.31)



> On 1 Feb 2024, at 16:00, Zhipeng Lu <alexious@zju.edu.cn> wrote:
>=20
> In every caller of hfs_find_init, `ptr` won't be freed when =
hfs_find_init
> fails, but will be freed when somewhere after hfs_find_init fails.

Current statement sounds confusing for my taste. I don=E2=80=99t follow =
it.
What do you mean here?

> This suggests that hfs_find_init should proberly free `ptr` in its own
> error-handling to prevent `ptr` from leaking.

I assume you meant properly here?

>=20
> In particular, When the switch statment goes to default and return an =
error,
> `ptr` should be freed.

I assume you meant statement here?

Also, you mentioning `ptr` but we freed fd->search_key here. It sounds =
confusing too.

>=20
> Fixes: b3b2177a2d79 ("hfs: add lock nesting notation to =
hfs_find_init")
> Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
> ---
> Changelog:
>=20
> v2: Improve commit message to be more clear.

Currently, it sounds slightly more confusing. :)

Thanks,
Slava.

> ---
> fs/hfs/bfind.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
> index ef9498a6e88a..7aa3b9aba4d1 100644
> --- a/fs/hfs/bfind.c
> +++ b/fs/hfs/bfind.c
> @@ -36,6 +36,7 @@ int hfs_find_init(struct hfs_btree *tree, struct =
hfs_find_data *fd)
> mutex_lock_nested(&tree->tree_lock, ATTR_BTREE_MUTEX);
> break;
> default:
> + kfree(fd->search_key);
> return -EINVAL;
> }
> return 0;
> --=20
> 2.34.1
>=20


