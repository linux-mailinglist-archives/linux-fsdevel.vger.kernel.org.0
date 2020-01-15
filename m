Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90C9413C9D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 17:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbgAOQmB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 11:42:01 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:40787 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728899AbgAOQmB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 11:42:01 -0500
Received: by mail-pj1-f65.google.com with SMTP id bg7so173450pjb.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2020 08:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V2uWqO7PQFpi/zdSVofh092jxm4FAhmJjQJPAhbVzhM=;
        b=dxK79Nck5Z1AUWDmVeAZ6wPqOrbTaXF13wjUbMrN3MEZeuMjXwYyUsJXQ2Um+Abf+T
         iHtKJeAW9g/zI4qGYpzqyvsZkyJ7Uke6dmg07EDswHlkioYwbfYAHXBHwinjW4WJZq7O
         9NzrGG5JwSk6acoypINPTR/I09dvd5g2CyDKZDwUsMKdz1uD12RcM3VrtrhBu+Md+oW+
         UFsYdcCxvg+Cd5f98epqIw+uCYd1ok7c3J3Xg3c5ezsTwqxmBYR/r+a06oS1dALdIo7x
         WGcybwGGUUYxCOEs/sAPa4yixmXeTJJdpOj0OwrevZ1B2HiqjaZoYo3vAGU740TI18vb
         dJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V2uWqO7PQFpi/zdSVofh092jxm4FAhmJjQJPAhbVzhM=;
        b=SDO54vXlf/n66uOrU/j49R0oRm7alzw+fsJvkhbxBUV9Fw8Wg4SqA4CmSknTwmndb5
         8RyyMR0IL2ruSN0KdQlhYYfEWAjBJbaR9iF7FMXryuFfxjZ+SYrVnC7c562JW7tt7JXV
         Finxhot4Mz8xrS56mtQcu9YjAmuqA4lmol61sY7H2Rxmo1JW30KGkeuWD2tKEsm3+m/2
         O56w0B3Hf5z8hhJv5lmF7bsJcX7RfYaNuxKAezVVM7D6mkN0sJaIuX9IKcgpt34sF1V5
         aVnEeVC4hNGiq6933eV1iYJmh2GnZz+nl+ZSvwIjibK6gZ6ymIi4AaNm1JZI5hWTvrYU
         RBMw==
X-Gm-Message-State: APjAAAU+OouUV18A1Q71eEWc34dFDJdAnX8F9U6dAdVyuOzcSBQk4IRr
        Q6f9AwAUkMqsnCupeMVPK64QlA==
X-Google-Smtp-Source: APXvYqwEUltaJGoxxUqBqGekg1fUtPf73MYWL11rqoSEPatWa4/mPEkQP/d1QMfUH39UIEN7TqcPlg==
X-Received: by 2002:a17:90b:3cc:: with SMTP id go12mr752934pjb.89.1579106520273;
        Wed, 15 Jan 2020 08:42:00 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1132::1049? ([2620:10d:c090:180::4bca])
        by smtp.gmail.com with ESMTPSA id d3sm21833134pfn.113.2020.01.15.08.41.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 08:41:59 -0800 (PST)
Subject: Re: [PATCH] io_uring: fix compat for IORING_REGISTER_FILES_UPDATE
To:     Eugene Syromiatnikov <esyr@redhat.com>,
        linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>
References: <20200115163538.GA13732@asgard.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cce5ac48-641d-3051-d22c-dab7aaa5704c@kernel.dk>
Date:   Wed, 15 Jan 2020 09:41:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200115163538.GA13732@asgard.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/15/20 9:35 AM, Eugene Syromiatnikov wrote:
> fds field of struct io_uring_files_update is problematic with regards
> to compat user space, as pointer size is different in 32-bit, 32-on-64-bit,
> and 64-bit user space.  In order to avoid custom handling of compat in
> the syscall implementation, make fds __u64 and use u64_to_user_ptr in
> order to retrieve it.  Also, align the field naturally and check that
> no garbage is passed there.

Good point, it's an s32 pointer so won't align nicely. But how about
just having it be:

struct io_uring_files_update {
	__u32 offset;
	__u32 resv;
	__s32 *fds;
};

which should align nicely on both 32 and 64-bit?

-- 
Jens Axboe

