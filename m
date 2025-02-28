Return-Path: <linux-fsdevel+bounces-42860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A609EA49E3A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 17:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27B5B172B0F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 16:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E74A16F265;
	Fri, 28 Feb 2025 16:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0Ff8vg2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A42142A87
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2025 16:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740758611; cv=none; b=IWNnRqqDsCj3EI7dJvbGBuwM0LVqezUIdEXd0qjZDG+O9ujzeft4juCL6KSLKZDOZS0cCm6Qc5v1yzWzLuZKNcxq7EmImJ9sqaQOGIPp7bjdthWVaXduTphOg3aaUa3BAJWkqjHY+F1fo8Sag+hsGPV35hk49CDFOBG2eIaPid4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740758611; c=relaxed/simple;
	bh=IDViRo7SmtVvok33drhxP6pbxgGH1H+DadIIZvpwEGg=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=AlrCorW4yzFltXKhIYS9ALQvXsaZscngnlcKt+ssPH8Zm+9wBcfFkdHrsuUckFMfE6js9PiuG0wWe+hvj6gP5NHrAphUSot67+kkfUQmkXGKt3AsqZDB5/qRzm7qlKisM+I1+1BUNrCZHKiyPzSglzgnCe/QtiRxCYVdy/oOm10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0Ff8vg2; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2fec3176ef3so1096906a91.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2025 08:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740758609; x=1741363409; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uTLIhGW0Z0WiRcdJUnoUYsp35SmKdJ8rK4znAPbB6Z0=;
        b=P0Ff8vg2TGxUPr+tOmoh/gdgCk2ovLv0yVtKsjJxIp7vb5N291SKOPuy78UqiSBk5p
         VyQtrvJ6lmN0bfxNSKazFaDmR1rdee1UJ3OkbvAu7l1kvAFw4PvH20nYz8a2YruuPp+V
         GPVxIZZaqdmG0Hfiz1VcnhpU9eZNsrT8aBfYPl5MFgjmtJn5eTZ5/8N6e1lxh07341XN
         aI2p3Ov26uUur2tJ5uzJH/IT7HLqhL7Ab5TeCLZCYcARfmhcdxUTrs7Z/oDNUagieu07
         w+kWwHXvVYyU+Cd393OAqId2bdQQsQd2S2d0gjydtEw0opkGDSB8ZbBsj24fjDDK7FwH
         yalg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740758609; x=1741363409;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uTLIhGW0Z0WiRcdJUnoUYsp35SmKdJ8rK4znAPbB6Z0=;
        b=WOCcfCDcjKMVQeaUWl11FepoAw+b7U72lCpoZJFzyGUdrvkKU82whxxnOIjLgxW5eG
         H3erespgnceQVHNFXCEuHsYRf4ujEueB9JLdOkcumQf5bgxLUy78rwAuGAnIKGKkl71r
         W/feoeBerflPiuFuEOXxYyXL7zBa1i4dokMMoeUCbTx10SqQUzFcURF0tWs5uBl0D9cy
         9ZPV6G9D/8PknPJ8bDauZ07lPkRd+aM8ajj5MYdDQWKTwlRyOJ3444h4+lNcKHgyZlEm
         ZZqIAU2+Gqo3vB+/lSvbwUa4mW/26SNPGa5y9Kr6jHGO/VcSD1+yVJ746PLh6jzBuXi+
         pvrQ==
X-Gm-Message-State: AOJu0YyKlw57JJebEbC6XLjIJUS9I82cIv/hjbPk+NQH7qFUW6YfXffN
	bdKMUJl1Hrdhcr89zvjnaWjZfXTfPmNsWEl5NFAfcpnYei5LB+IhYJ5tVg==
X-Gm-Gg: ASbGncsEUHzlr+jWARLvf9oq373LgetvYn6C4nIBPSiDb2HV1x+ByGGbmKIY3riCZdv
	NeGhdrvmIWJtyYGFnyUYse1SC1QFCcnLFEKVlpaRj3THD2BVnigSyqDfLs1Ca8H4236KxfZwuEt
	3VYMGWP5D7NpYlWBY6vA0OGeMZVzDvMscL5mtga4hkiOJrImJ/ocMAjlniVxgS1V+ToaeN11epT
	2cNnVh21PujJRq6BsAa9PM7sGyE2n/U2r2lvvAlAWUzUzK9D5NUIIGu6kOIEqN3R/AseA7LJtLQ
	GwK+BRSg7YgjQFRmuueQ0ABh8/DEGBa1dQ==
X-Google-Smtp-Source: AGHT+IEhNEw/AxZwA9/yYeVUhkTn6+Bbt5RCB0x2+tMMrNxXn3LSUmii6n5rC6Ig/izBpjSx79vygA==
X-Received: by 2002:a17:90b:1805:b0:2ee:f550:3848 with SMTP id 98e67ed59e1d1-2febab2ee96mr5843554a91.5.1740758609241;
        Fri, 28 Feb 2025 08:03:29 -0800 (PST)
Received: from [172.26.235.44] ([223.39.179.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe6ded68ebsm6113871a91.1.2025.02.28.08.03.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 08:03:28 -0800 (PST)
From: Sungjong Seo <sjdev.seo@gmail.com>
X-Google-Original-From: Sungjong Seo <sj1557.seo@samsung.com>
Message-ID: <394ca686-a45a-e71c-bc45-33794463b5fc@samsung.com>
Date: Sat, 1 Mar 2025 01:03:23 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: sj1557.seo@samsung.com
Subject: Re: [RFC] weird stuff in exfat_lookup()
To: Namjae Jeon <linkinjeon@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
References: <20250227224826.GG2023217@ZenIV>
 <CAKYAXd_-v601SX44WZ970LyZjsCH3L3HFjJXxZH960r1PXo+Bw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAKYAXd_-v601SX44WZ970LyZjsCH3L3HFjJXxZH960r1PXo+Bw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello? This is Sungjong. Currently, I am unable to reply using my
samsung.com email, so I am responding with my other Gmail account.

On 2/28/25 14:44, Namjae Jeon wrote:
> On Fri, Feb 28, 2025 at 7:48 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>>
>>         There's a really odd comment in that thing:
>>                 /*
>>                  * Unhashed alias is able to exist because of revalidate()
>>                  * called by lookup_fast. You can easily make this status
>>                  * by calling create and lookup concurrently
>>                  * In such case, we reuse an alias instead of new dentry
>>                  */
>> and AFAICS it had been there since the original merge.  What I don't
>> understand is how the hell could revalidate result in that -
>> exfat_d_revalidate() always returns 1 on any positive dentry and alias is
>> obviously positive (it has the same inode as the one we are about to use).
>>
>> It mentions a way to reproduce that, but I don't understand what does
>> that refer to; could you give details?
> We need to find out the history of it.
> Sungjong, Could you please check the history of how this code came in?
I believe this code is intended to address issues that could arise from
the stacked FS nested mount structure used in older versions of Android,
which are unlikely to occur in the general Linux VFS. However, I will
need to look into the modification history to confirm this, and it might
take some time.

Additionally, there is unnecessary code remaining in `exfat_lookup`.
This is because linux-exfat is based on Samsung's fat/exfat integrated
implementation, sdfat. We need to address these legacy issues one by one.

Thank you.
> 
> Thanks.
> 

