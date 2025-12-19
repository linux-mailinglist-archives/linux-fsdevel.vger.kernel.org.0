Return-Path: <linux-fsdevel+bounces-71723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 515C8CCF252
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 10:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E4753027A5C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 09:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D907C2D7DDC;
	Fri, 19 Dec 2025 09:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OjtqKXjy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WRQL1dsI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850382D7DEE
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 09:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766136524; cv=none; b=bPGfl9YJ3qgjCOlWanL7jnjD6eP+JbMo2JHlw7dwwzLmb+Ak1oRk2Y9j2B7yWf3QjyZNSg0vHdpmB9tKJkypZFWbkwJssE91AuXg9QPJo5taGn1uys6G2j/2haDITMC2I3w4dStxkb51755zclYGnK8NetXkPI2ehMoo6oKLZXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766136524; c=relaxed/simple;
	bh=a9kGWB2VoIFD5H0J99TkVfZ6uDR6K/PyNGlZcO7cFag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HJVDuBv0731FxWpH+Lrzci1QC+5c68gZ+EWFafFxyp208/Aesy7fM4vxx6sDL2oIxpMrpiPaCJw9ZXEt9FdoJuuQaCWmk52AISKyWa5AiDjZqiqcRDA0mw99P60nwFz0sDkcy68oonXZgpio+zQBHJ1v0lNzrbh5pAEl/+zewio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OjtqKXjy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WRQL1dsI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766136518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H7haCuyhI51FS9KbOrG4WJkMhKxZs4nFFL4lqUWoH9E=;
	b=OjtqKXjyppEiWYKcionWlkJEg7sjAeg+j9USt2DcLdQRFEHtg5sIpgiziWofMrQL5SGWRi
	0saZwRdbEBXtd9Kz+8q7bDLMnMFgQYX5oI3IgKo5K2uSRKx+/EG1gzrLpXQIDJvqzma1fx
	FEAfPPBfAZXffCmnWSQajEPTzoUucJc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-69skrthRP9-MJZ5ngmojVQ-1; Fri, 19 Dec 2025 04:28:35 -0500
X-MC-Unique: 69skrthRP9-MJZ5ngmojVQ-1
X-Mimecast-MFC-AGG-ID: 69skrthRP9-MJZ5ngmojVQ_1766136514
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4776079ada3so11756475e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 01:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766136514; x=1766741314; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H7haCuyhI51FS9KbOrG4WJkMhKxZs4nFFL4lqUWoH9E=;
        b=WRQL1dsIbkfiQi6LcB6gpdyawE6x4n+UwwgvUzeQpD5QfD2laai4OJWc2MbU7/JvAL
         bbzFG4p3TlDYjWso6L6htwXlCyRfKgN1NP30O14icmeuem3/G0XYsxJHCMzl2ofiBO3k
         ZQTv4+VcyDUZHnuyMydRCOtsIuYba7JiYC+H21H1+Q2mXnXiIyqK93AcrzOETbmEbGU+
         AF34nXSR4ZVScn2AVdyb8ggSVkE3CgfW0Xe+oIUzZcROCig4LyIIrNKWj1p5R5nfJfa/
         U2wCOoCGGITdAA6qalYDGZ3lChXFbBLxDIHNqVIRVCnnIvgLcw6OXUjbOoiLEZh3UO63
         XuSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766136514; x=1766741314;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H7haCuyhI51FS9KbOrG4WJkMhKxZs4nFFL4lqUWoH9E=;
        b=i8jowvVL1qJMCqvzqWmn2agTAl+KzeGafcGVVfuvJmppnh4A5SSg8waidfsHMKGSlS
         w29KHujSvVzKJu2EvNZ0yOD8i0Rxj2G7nfiqAo6GHheVEt4P7WCISWOr/FabVuXyeEzG
         la19Tq78gbnGzPS5G1w6F4rq06pefp5hffuuvXVaaMVznybuV3vuhfzV1nFtt+ZmWaJg
         lzoCiIbFCseQO1+cnAweKCElMapgrZ8f2+eWdhYSZQlExKcT1td6c8eoqkBZBuNd4fQv
         cG60OA7xmsIbK+rj03z27zpNIz1MAaR2bM+q+2giD/bK9DDcFB3TGakyXlMx8uyaV/5a
         vwtA==
X-Gm-Message-State: AOJu0Yw5xvVKfYrYzwHb3C/pcLQo0qfDbFC4KVm6kpvB6lc2psYjnTdO
	JDM3nSQ2PuJhKGjfpMihwGQ8Gjh6aYx48DTTAgOo2hu/RARkB1aT+ZNTH0j5lDfORpNsG9AkhO2
	b9MR8QKrdfHGF5Y+FSxrBLqjBwp+REaez0CKRtiAMhi2Ar1zZci/VE1wurXwose4RhI4=
X-Gm-Gg: AY/fxX602237tcJJxfr4VUmEHRXcGfAeNergDHynz/27XCJvatSSTnBKWR0TwGkUEVn
	3EQ+YsOj6X0WfOg79/gRAmiu4wOzIMmDprBRGuOpmT1uzXzi8LSaN4FM7gRf4+8hgUfxh5JmtWB
	fBrcCVgrzCwP6BiObrKHBx4roQM07lqdO0/toZQPyizdORzOHo0RvZ9kjDLx7qMIUdSSIsl9wDZ
	BOq3aXA4x0cN2cFsA6cUmPQ61C1hydMrsmlJhHz0oylVUci3jkmSuoDsmgMl1eI+ocdcEMj89yB
	TFI8CnlKlxp+bXkjIprDKMVDC5aelF5bgUsyJGnHYF+oOLLgmAHc6xhNOwLZ1NKDJmO/V6CdMQt
	k33A4WUnLOCPH
X-Received: by 2002:a05:600c:8107:b0:477:6374:6347 with SMTP id 5b1f17b1804b1-47d19594ce3mr17951265e9.22.1766136514143;
        Fri, 19 Dec 2025 01:28:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNoLKZcFi3Edz90O7ZAZd0UW0hmk7eXl1jBJlmWTqebq88oohMnYaPL71A6ehr5HyEB8Y1LQ==
X-Received: by 2002:a05:600c:8107:b0:477:6374:6347 with SMTP id 5b1f17b1804b1-47d19594ce3mr17950875e9.22.1766136513687;
        Fri, 19 Dec 2025 01:28:33 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d19352306sm34590835e9.5.2025.12.19.01.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 01:28:33 -0800 (PST)
Message-ID: <1491a7c7-3ff8-4aea-a6ee-4950f65c756f@redhat.com>
Date: Fri, 19 Dec 2025 10:28:31 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sysctl: Remove unused ctl_table forward declarations
To: Joel Granados <joel.granados@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 David Hildenbrand <david@kernel.org>, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>, John Ogness
 <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-hams@vger.kernel.org, netdev@vger.kernel.org
References: <20251217-jag-sysctl_fw_decl-v2-1-d917a73635bc@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251217-jag-sysctl_fw_decl-v2-1-d917a73635bc@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/17/25 1:16 PM, Joel Granados wrote:
> Remove superfluous forward declarations of ctl_table from header files
> where they are no longer needed. These declarations were left behind
> after sysctl code refactoring and cleanup.
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> Acked-by: Muchun Song <muchun.song@linux.dev>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Joel Granados <joel.granados@kernel.org>
> ---
> Apologies for such a big To: list. My idea is for this to go into
> mainline through sysctl; get back to me if you prefer otherwise. On the
> off chance that this has a V3, let me know if you want to be removed
> from the To and I'll make that happen

For the net bits:

Acked-by: Paolo Abeni <pabeni@redhat.com>

I'm ok with merging this via the sysctl tree, given that we don't see
much action happening in the ax25 header (and very low chances of
conflicts). But I would be also ok if you would split this into multiple
patches, one for each affected subsystem.

/P



