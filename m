Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA0EF2AA65
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2019 17:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfEZPZ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 May 2019 11:25:28 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42902 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfEZPZ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 May 2019 11:25:28 -0400
Received: by mail-pf1-f193.google.com with SMTP id r22so5208149pfh.9
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 May 2019 08:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=aZIYcTZb49nLbN4UbdL20Sk9v3C/xflMGyTZxH5wCk8=;
        b=UmS45A4XmHzsBrF5XzvjN7YRvRJkXkEMy6lEi+0jjpMdbuDSj5z1PG72DHfPmlVzPr
         TAceCEqACAJk+wGxtpfZ8o204qebabOxOEIPjsmqu3DCvXINoxO8k/Nr30dMzhkD8Rzc
         CbpYLnS4c821E6J9Q7cxYXFNgXzRoML84omD7e/sZY2XhrWWgIG91qRARUlt5HQqdFps
         GeALwFl6PkpCYSvwmESdIAiJoav+M/VpZKmkAjMyPvw/Ehx+jeRJtx4I0/a8iVHvuW0R
         JXWJi+bePJoOGbfyrCTfzlfgZQWB0v6EoC9ORe0y05otJlwK1Ys+G+uPGTtEhFzkzu9R
         8C2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aZIYcTZb49nLbN4UbdL20Sk9v3C/xflMGyTZxH5wCk8=;
        b=m/RknuQKr9ArIblDNXGnGE+ePzJBtL4x1XuI5siItSszclfo9QsQoKJdKk8c8Dc/Gq
         OGfWBJgnZp6DX/QI41TsI7orZQ2q9MWDJNrEB6OUrd3USY1ARduWw3jR3ykrDFvNN7wR
         v+i7sm4Blszu0fj2fCf1zLuiJjvd9Vkq8y8945aiprs69pzf9Flvsy3EJHGlEG1J6Tgi
         xoa3CQNlqwdXz09Yu1HGMyoeldhjXPjkNu/bg2XE/8oqgpbOXwx+8wMNUpZhvrv153iG
         baDqMmEW+tHUFFEH4b7xZn05Y5anJqLaY9i5uO1SR9xe0RlX74ptlInbJS4tER7Z1sik
         nIIg==
X-Gm-Message-State: APjAAAUb5D6tm0uXWxPGCG69nusLrm9hkxryGuU2FKGHAPLwXtn9PQX9
        wURH5g5wlS3t+uHhTz7g9nrwwA==
X-Google-Smtp-Source: APXvYqyzbIPRRr1xDnDYuHHhxapcwsR/49J4utmIw8/unCWstSF4sDUXprbl7ZI3PIJ55C19ERkKiA==
X-Received: by 2002:a62:4d03:: with SMTP id a3mr131986235pfb.2.1558884327722;
        Sun, 26 May 2019 08:25:27 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id j7sm8743596pjb.26.2019.05.26.08.25.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 08:25:25 -0700 (PDT)
Subject: Re: [PATCH 1/1] io_uring: Fix __io_uring_register() false success
To:     "Pavel Begunkov (Silence)" <asml.silence@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <f9e0372fd0e52ca276bb307da1271908cab4efb4.1558862678.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0bfeca3e-2485-3679-a3df-10bb22237fb5@kernel.dk>
Date:   Sun, 26 May 2019 09:25:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f9e0372fd0e52ca276bb307da1271908cab4efb4.1558862678.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/26/19 3:35 AM, Pavel Begunkov (Silence) wrote:
> From: Pavel Begunkov <asml.silence@gmail.com>
> 
> If io_copy_iov() fails, it will break the loop and report success,
> albeit partially completed operation.

Thanks, applied.

-- 
Jens Axboe

