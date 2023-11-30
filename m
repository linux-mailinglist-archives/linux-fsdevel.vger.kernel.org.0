Return-Path: <linux-fsdevel+bounces-4411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF7C7FF254
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 15:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0F351C206FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F5751006
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DMAA83gE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496E993
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 06:23:02 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-35d380a75a8so92015ab.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 06:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701354181; x=1701958981; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OHIryu2wZ1gnh4ifYho13U48w2JoFY0bqo6Bee42wTo=;
        b=DMAA83gEb8g54KZDzu2hoHV3bwOd0RIRbHRNE2T9WO7beH/4I/y6+sD0myMJlkCyGu
         2M9+L4SGVkU0jqV99X4rbAl9oWmJR4i/M761h6zsFaTly050SwlfHPv9MZdP7hj7vIx1
         u5QcC96akOgurqPxXTJw81Du0onq1gGE8b1rKGXLZVHvQyOWe7U63zYZAjXUr2941cr/
         2iLi+Gl2QQzunV3KBsqmEXeQBceb2uFaTnWhHjSgg5i3dMoTCq1rWmRd8MJPvQcsH69Q
         2WPXDISTf2BRV035bGXgTju+6w3RJI76VWuFuQUzv4x940W707Mk3VXRdeeESN75bQYZ
         GLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701354181; x=1701958981;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OHIryu2wZ1gnh4ifYho13U48w2JoFY0bqo6Bee42wTo=;
        b=TaTOpefJTD/n/eC6mou/Gy80+epOnHBPI7Afn6bflUX54L6jYzgIBFCOIYFam53KsK
         oAXQfkNzlBGyjHAkEZ9pUYZyQ8QRVVlt6KxlmqW+FSinSVfxnx3s/3CR/DQV/cvr1hLC
         3mbVjDei6apWuyLN0nAbtbu657pL5vukZwOdlnhRFTBU72MV69n0PWdv6EkmBWX0FEhR
         yFfENr6uN1++tAXLjohxRmnUr+u2jswACcGxUo3B9Cpnv0UhWTYESAV293rg5hjnQd+Q
         Fmw0lQHjIqWMzxYPcennieipkavS+8OCo3UIkC37/yeUCyogUADPd2y/r3k7pTHHNAqe
         SKlw==
X-Gm-Message-State: AOJu0Ywc2d3dUtve913ml0otUq6MMyLc5G9ZRPKpuK1w8p9wFUV8FSdw
	t/MQhy6Y2aRGPxVs2RcMNbjo8A==
X-Google-Smtp-Source: AGHT+IFGk7gPyfMn9OnHzF5Hgb2va1r4f+rEmgW/X7MZQbHpp6eVzhhGocDS/Hy/xqUtun6U1MQsTA==
X-Received: by 2002:a05:6602:2bd5:b0:792:6068:dcc8 with SMTP id s21-20020a0566022bd500b007926068dcc8mr2170647iov.2.1701354181550;
        Thu, 30 Nov 2023 06:23:01 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id n26-20020a02cc1a000000b00463fb834b8csm308647jap.151.2023.11.30.06.23.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 06:23:00 -0800 (PST)
Message-ID: <342126a9-c25e-47be-8274-b19865f53f3d@kernel.dk>
Date: Thu, 30 Nov 2023 07:22:59 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/5] file: remove pointless wrapper
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.com>, Carlos Llamas <cmllamas@google.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <20231130-vfs-files-fixes-v1-0-e73ca6f4ea83@kernel.org>
 <20231130-vfs-files-fixes-v1-2-e73ca6f4ea83@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231130-vfs-files-fixes-v1-2-e73ca6f4ea83@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/30/23 5:49 AM, Christian Brauner wrote:
> Only io_uring uses __close_fd_get_file(). All it does is hide
> current->files but io_uring accesses files_struct directly right now
> anyway so it's a bit pointless. Just rename pick_file() to
> file_close_fd_locked() and let io_uring use it. Add a lockdep assert in
> there that we expect the caller to hold file_lock while we're at it.

LGTM.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe



