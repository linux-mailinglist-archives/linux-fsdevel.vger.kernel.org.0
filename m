Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73A7417B412
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 02:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgCFB4B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Mar 2020 20:56:01 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33115 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgCFB4B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Mar 2020 20:56:01 -0500
Received: by mail-pf1-f193.google.com with SMTP id n7so308846pfn.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Mar 2020 17:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kaXeesIPPJMvPx4kXVh7gCp+Z3uzVmJEDAEEcWfSDtk=;
        b=m0uGG95jnfdlAWS1zW5wrVlOCbHvBqS4pnLjhYDwoHSUSeZ0mdxsG7TrEgIOVlMyjJ
         XkqhXyi+g1rDj4yGoOYDzALFjGqSGhoAURaZPXV1WpQCz5ZEz8K7+C/j8ypaEekRQ5vX
         nG83Vbtwn11cHwxzs5q997ZKprD0v4/UHFRFyf84aZqL35AcJR4+nYOiO3zDUbZSHMEb
         ctLVvigiannkuT0QAk7SzuW6eUfJ5dkrx+E007kPyW4wT/qn6WevAXqYPHJ9Tu67CPjF
         HZhrubOk0/1pK7pirS8FoMwv/UibUoJ8ZYbez9HmrKF9Uj6vcglRbIPFmyM28N3iKiBN
         ekmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kaXeesIPPJMvPx4kXVh7gCp+Z3uzVmJEDAEEcWfSDtk=;
        b=P84hqeV20icM2pd/trJ4opd1SRTTid6AWo3J16P3HXkDXdHaBYOEayJSoTZA4HYeth
         IDXUTRu9zWDaf0bgOpqArn0qpYSZURA1kyRsUzlrnzvsAwe2dczcGaoycziqgzK+6bcf
         5WyPGGajDcR1rrNK0J5VkxX3Y0R0nPGJpo3IZsT2ks+ndQkXFkgJlBNVk4OIL4uinMPz
         hWn6zyx5BQiSCTp6bKWONIAtp9FqBlPkaJ+F7yVaZ0jmF+P7EXGyateQ7YCj+3VnPxaB
         E/EhC+25tULAL+BivY1iE/9S5EpPa6+sh8/k50VdvbYOSOb1aokZnYnSDA8FfB4FeoPD
         Hy2Q==
X-Gm-Message-State: ANhLgQ1b8xdiaotClV9kb4A9ZkJSJebH70GI6w43W+2RXquGepK5CZDC
        2BrrvP2RvBAu6wOqhEi0fsak7Q==
X-Google-Smtp-Source: ADFU+vtqOTPBL+DI0/5IBgeGnVtrkQZjNncicf0Rr++POXk8uMRWYzPeLE+yHx0D7xZIm9ix3RJqHg==
X-Received: by 2002:a63:d10c:: with SMTP id k12mr962268pgg.392.1583459758864;
        Thu, 05 Mar 2020 17:55:58 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id x16sm6615906pfq.40.2020.03.05.17.55.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2020 17:55:58 -0800 (PST)
Subject: Re: [PATCH] io_uring: Fix error handling in
 __io_compat_recvmsg_copy_hdr()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20200305200544.5wmrfo7hbfybp3w5@kili.mountain>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8ae4f1e1-9158-4ec8-e6fc-87c836093b89@kernel.dk>
Date:   Thu, 5 Mar 2020 18:55:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200305200544.5wmrfo7hbfybp3w5@kili.mountain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/5/20 1:05 PM, Dan Carpenter wrote:
> We need to check if __get_compat_msghdr() fails and return immediately
> on error.  Also if compat_import_iovec() fails then we should return a
> negative error code, but the current behavior is to just return
> success.

Thanks, that certainly looks better... Applied.

-- 
Jens Axboe

