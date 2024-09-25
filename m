Return-Path: <linux-fsdevel+bounces-30018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08170984F44
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 02:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB3751F2466F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 00:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B47C1CF93;
	Wed, 25 Sep 2024 00:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWGj1cbx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A63A927;
	Wed, 25 Sep 2024 00:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727222490; cv=none; b=MFwiHAOD2QSL7G9U0r1cDwvlCw9/YwILA1uNGQhdmn1i5WS9nt4IVZC8DNJ4p6geQUmViB5+hDh/9UNFtRdB8w2noP3QjBBhFyOMbU7wh8ALUdKznk4xJiCof96yRNcvusBKm6uDVqwoPJFvuFqopgINo0ISnt8drHVlJEs4ZVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727222490; c=relaxed/simple;
	bh=eg6JUadNkPeoBu23FSpRWKZpfeLOFZgr8IlFAdMKgy8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n8wGyuCTvbDWr/Tw4xHJu4PmeSRkH0HdSJwBpbBv3dXj0Srx9mITa6RP2NovaxT8Kqv6vtlfpO/aY3xjuRyRTa3zvABhOssuo6aP7f70AAxMT526K0twMlXSQ09w0IT4lJ2CBsONPmC98BkPrBnZu38ri1I51sy83V0pMTN8RHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWGj1cbx; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71979bf5e7aso4299878b3a.1;
        Tue, 24 Sep 2024 17:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727222479; x=1727827279; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G+YsbtnugTHXPyFLA8DhHEyqiW3ql0VvB9hLLtok8vQ=;
        b=UWGj1cbxc5I37qTt8ASUdaAzsDRtjtZXFjSaS4elQVkr06y7K4yt3gf+4tGkFAPJpp
         veB5jdN6YYyQk2NemYWWN5PkNSE6kd+aKaVXstXnp6oD+T+k05R20D5mq/PET46waeI+
         pfTQnEKEW7XF/4WlNSQ4tpK6MqUbbhn0NsEzYbLwVQ3HbKBdof0hHJA55c0h35s4QRgx
         5vKeKqfTvUSgszFVEPxQYWsLJwyV0FCsnE0nNz1pT4L5J3zQMpz2QYisFYDG9QYjIX8V
         BAOwgnS0X7/9v/AHUIK2/85OIAS2wIAKmFUq2B2vShcmqbtZiRlQ1leOPA/nTOHjGssH
         +FKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727222479; x=1727827279;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G+YsbtnugTHXPyFLA8DhHEyqiW3ql0VvB9hLLtok8vQ=;
        b=QA6Kw6HcFM/4GkQakPcrIqeJEBgyqFgp+xGzlAKPNjkxuYtQ6iZ6GwnGvOPaVa6khC
         v9Xvz7jetNZUw2klFsGKfSNZzChUZzZ7KdFmr2ePWe32eEZEHKH8C7FW8g7m5Qv6aJ+f
         qtAHbWyteO+6V0kBIuiR2acmY0tbuikIS2tAoUcvxm/+7p9yVYZB/3XjNqujLyElf2LS
         ZFwhxqRjefS9vWnvl8IMODd0u6rvq0Y7+YYj07Ndx8w8dSLDcEidHK4izpthN1WucJnD
         W4sbBEQ3Pkw3T4LeUTXgEafeV5LPJvRcJodyvNpvLc+KIH45ZpBzBu+Tlvr3O37m/0ZQ
         ZyHg==
X-Forwarded-Encrypted: i=1; AJvYcCUD/I3ZRVSPAXFKPOeVIsB9bTK5ICNXLaMvN2hWBH09KX4Kozpw+EEX9d3I9XBdj7qM95HjHbYHeGg/@vger.kernel.org, AJvYcCVo4q1cWhtYcNhHFk5n/bZ6xz/7U+wW95fmq7/uSElJYd4iNLSaIXwP/gzE+LY/uTILA/z+yqJl87xHSfZc@vger.kernel.org, AJvYcCWkKxTWZu7ri5BIC3Vxe4gLPmaBTgiKLyOnK6EU14OujC8sZ0MVxrTrA9OUACWbVKKHhxeOMDkN45C6dA0THA==@vger.kernel.org, AJvYcCXSqVLI+Ss81AGAbb408ywbOL4Kkvq0hyWCTvdJ3v8IldB7EnBgBAcB09XZ0lKcgyGg9JNtfEjx0U3AHQ==@vger.kernel.org, AJvYcCXiATZpbIJrJ4fgszArQhBqnzgRieYcZYBR69GBimFJeuMTJXoEeCLq2Bjs7F9KepLiwDLaDaUSEI+T@vger.kernel.org, AJvYcCXyfUEP/R+ogXtW0qxmcwTKYkEEVLxvl5lAMBra3g23k1R09IHTtAy50UO1yKyhduYAqF33yjjJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxAawhAUem/opbDMgUqFPa82F5AjLDWydIJxPGoqtJeHVUi5G3u
	kKXb7naictdNfGq9a+R173j+DJir1RFiLwgtC39pT407DWZdELKK
X-Google-Smtp-Source: AGHT+IFvocGse94WXxiZf5ejfW8ZMZrfybKRDozJJhDfTj+R6qo5a3bNsb79W/etWWrqI4tOhHvi1A==
X-Received: by 2002:a05:6a21:e8e:b0:1d2:bc8f:5e73 with SMTP id adf61e73a8af0-1d4d4bc0cc2mr1117741637.38.1727222478887;
        Tue, 24 Sep 2024 17:01:18 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc9cbc02sm1675483b3a.213.2024.09.24.17.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 17:01:18 -0700 (PDT)
Message-ID: <4b5621958a758da830c1cf09c6f6893aed371f9d.camel@gmail.com>
Subject: Re: [PATCH v2 19/25] netfs: Speed up buffered reading
From: Eduard Zingerman <eddyz87@gmail.com>
To: David Howells <dhowells@redhat.com>, Manu Bretelle <chantr4@gmail.com>
Cc: asmadeus@codewreck.org, ceph-devel@vger.kernel.org,
 christian@brauner.io,  ericvh@kernel.org, hsiangkao@linux.alibaba.com,
 idryomov@gmail.com,  jlayton@kernel.org, linux-afs@lists.infradead.org,
 linux-cifs@vger.kernel.org,  linux-erofs@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-nfs@vger.kernel.org,  marc.dionne@auristor.com,
 netdev@vger.kernel.org, netfs@lists.linux.dev,  pc@manguebit.com,
 smfrench@gmail.com, sprasad@microsoft.com, tom@talpey.com, 
 v9fs@lists.linux.dev, willy@infradead.org
Date: Tue, 24 Sep 2024 17:01:13 -0700
In-Reply-To: <1279816.1727220013@warthog.procyon.org.uk>
References: <20240923183432.1876750-1-chantr4@gmail.com>
	 <20240814203850.2240469-20-dhowells@redhat.com>
	 <1279816.1727220013@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-09-25 at 00:20 +0100, David Howells wrote:
> Could you try the attached?  It may help, though this fixes a bug in the
> write-side, not the read-side.
>

Hi David,

I tried this patch on top of bpf-next but behaviour seems unchanged,
dmesg is at [1].

[1] https://gist.github.com/eddyz87/ce45f90453980af6a5fadeb652e109f3

Thanks,
Eduard

[...]


