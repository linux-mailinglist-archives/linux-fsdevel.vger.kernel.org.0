Return-Path: <linux-fsdevel+bounces-41122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5588A2B395
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 21:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 107CD3A79BB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 20:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC951DC184;
	Thu,  6 Feb 2025 20:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IOPv3Nc2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E631D8E01
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Feb 2025 20:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738875011; cv=none; b=ogDf2jtFux/dXGpFMBFQ8UXgl0d9NB/1m9Rbng2EO/d/x1Ha5EfeHWC87d9rbDks7lqCeM6hrlM0HlmN3gF0ksUVdTIjhI1I3Cdz299LC82k0O6cXRUb4I0dRJSSq8XdxuAZKJDCtQCqE9KtqjZRJxh4joSnwbi7r+WhWAlz5d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738875011; c=relaxed/simple;
	bh=nQG33Huz/RJ26x/KpRSxkU5XRcQ9e/a3aCHLb7O4+fk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QPMZ0E3FoMVUKVU6SioAXGAMOzKDsCig0TyR8gg2QqJiuVUINI8PVXxfYwsNleYtXVcO6F2KQG/wJDlcG163PvljlI9ENf0tykCft9+HEjuuwlhDugNySRsLicwqgOzJMgBDq1mZarbn/jcCg++7qplNdbB7ilnwqNpjfVgtrc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IOPv3Nc2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738875008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2jLFCxHLVjPyBpINbgKuvp8RyvizQvi1+ogCNwnIkE0=;
	b=IOPv3Nc29KQ5KMoiTtoHvASarynC1WDzFeHOlAvZjNZ04ES3WxWptx6PMTwnbX6ks7QF6L
	8qwKwVuopoDZYYg/1AH0u4jRg/TRL+se8bGMwZv0VYvHbeLhO4p7oyC8qx/bqIfc6chJcS
	dZIeBCaVCPxRr6dF7wf5iYp0r2guYlo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-HcHx4N_NM-Csc-GUcrfVwQ-1; Thu, 06 Feb 2025 15:50:07 -0500
X-MC-Unique: HcHx4N_NM-Csc-GUcrfVwQ-1
X-Mimecast-MFC-AGG-ID: HcHx4N_NM-Csc-GUcrfVwQ
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ab78afc6390so1861066b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Feb 2025 12:50:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738875006; x=1739479806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2jLFCxHLVjPyBpINbgKuvp8RyvizQvi1+ogCNwnIkE0=;
        b=vIdqs3P/r0QQRaHoMpHpsIcJdlR0+qLUYLseUBTXKVtsQdH7mbc2gJFnJTZC7vUGoE
         afJceoQkbtM/H9wCK2phbFB768Gho6QTwKV9SHj0YCk29wDZF/DpzeubAfqv+asPAjfy
         WYCC4pREZIh+A4trjocwurDsmrJy744jvnuk5WYf16LlxWJKFmTokYw7ADFwauaKGhCZ
         E38VLDYc0DjHlOIw+4AqBGEyMqvKwzoi8X/eoudrTnpkW/WWOeF/4WL/oO+G+OaKBF0a
         a8QeWczRzQUAZX1rrtQAj+zT6H7CLME8Q7t5OW46TFuLK0FcrK0rk9jQO5LDpc7OH0kq
         H+Cg==
X-Forwarded-Encrypted: i=1; AJvYcCXUjIXRvhQc3mPbARGY2OMufbhSMpahhlx1CPmh6nsnC6sZK4TuyTaY76lgebX3HXMkTt99hgzo4fi1a5ZV@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3FSWDs8iiPryhSg1VOhQHUL05VuPJ474Yg3+pPs73e3N7sAlL
	yQduo2s4yYMWB/ZT+pI+aWKlhu0eIMxCL3SuPiUH4XgFKTci7nPqFkx0rDKzw9DBBbKCBvQksMt
	a12yHYw41oNrgqG+zss/Pw4BggJJngGEO6IS93LWrX0xV0TJIyfMmf8eHCzFjhY2wsqkIxK0THJ
	2qoPr3xRXcJdTjG4GH+abjMAcG7zpqky1kGrZaBQ==
X-Gm-Gg: ASbGncuK7U0SnBbDj/Vf4cZFbmFUs8TeU4yaZONo8gfMBXGEYjd+DZOSU7d+TfyUMQq
	YPUsNn6+dnw6E9urfN897A88tA+D/eBDGR0BPL7kj82Dddtu7A7w2XTmRP5/YQg==
X-Received: by 2002:a17:907:3e8d:b0:ab7:63fa:e49c with SMTP id a640c23a62f3a-ab789cbe110mr33653066b.36.1738875006487;
        Thu, 06 Feb 2025 12:50:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmlPfqCpQklbkFCXxW+VzYDbfHTJwVxdQIqc5X3hkqM8xGSlv07PTlZr6jdUAcfaDbyMt2H4iSyZDaLtbBJZ0=
X-Received: by 2002:a17:907:3e8d:b0:ab7:63fa:e49c with SMTP id
 a640c23a62f3a-ab789cbe110mr33651366b.36.1738875006155; Thu, 06 Feb 2025
 12:50:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206191126.137262-1-slava@dubeyko.com>
In-Reply-To: <20250206191126.137262-1-slava@dubeyko.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Thu, 6 Feb 2025 22:49:55 +0200
X-Gm-Features: AWEUYZmnW76Y5y4OkdtiQyLHG92zS6DklmFu7MdOwieBOCr6Eu4C9zlGMtJ3sRc
Message-ID: <CAO8a2Sjor8_Uu-uAm9JXR2MxQXuwy3nsddDkL6exj39W1PbBkg@mail.gmail.com>
Subject: Re: [PATCH] ceph: add process/thread ID into debug output
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, 
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com, Slava.Dubeyko@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

On Thu, Feb 6, 2025 at 9:11=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.co=
m> wrote:
>
> From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
>
> Process/Thread ID (pid) is crucial and essential info
> during the debug and bug fix. It is really hard
> to analyze the debug output without these details.
> This patch addes PID info into the debug output.
>
> Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> ---
>  include/linux/ceph/ceph_debug.h | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/ceph/ceph_debug.h b/include/linux/ceph/ceph_de=
bug.h
> index 5f904591fa5f..6292db198f61 100644
> --- a/include/linux/ceph/ceph_debug.h
> +++ b/include/linux/ceph/ceph_debug.h
> @@ -16,13 +16,15 @@
>
>  # if defined(DEBUG) || defined(CONFIG_DYNAMIC_DEBUG)
>  #  define dout(fmt, ...)                                               \
> -       pr_debug("%.*s %12.12s:%-4d : " fmt,                            \
> +       pr_debug("pid %d %.*s %12.12s:%-4d : " fmt,                     \
> +                current->pid,                                          \
>                  8 - (int)sizeof(KBUILD_MODNAME), "    ",               \
>                  kbasename(__FILE__), __LINE__, ##__VA_ARGS__)
>  #  define doutc(client, fmt, ...)                                      \
> -       pr_debug("%.*s %12.12s:%-4d : [%pU %llu] " fmt,                 \
> +       pr_debug("pid %d %.*s %12.12s:%-4d %s() : [%pU %llu] " fmt,     \
> +                current->pid,                                          \
>                  8 - (int)sizeof(KBUILD_MODNAME), "    ",               \
> -                kbasename(__FILE__), __LINE__,                         \
> +                kbasename(__FILE__), __LINE__, __func__,               \
>                  &client->fsid, client->monc.auth->global_id,           \
>                  ##__VA_ARGS__)
>  # else
> --
> 2.48.0
>


