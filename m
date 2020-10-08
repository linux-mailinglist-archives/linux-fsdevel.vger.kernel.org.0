Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F152879CF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 18:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgJHQQK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 12:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgJHQQK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 12:16:10 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D4CC061755
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Oct 2020 09:16:09 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id k6so6818500ior.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Oct 2020 09:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MXGKdXgV6wJNdOluiYAUCg/NRvd9faNoK+7jU+DVzqk=;
        b=zCT4EDCmvezByHBFYDBPCHZAeJbfRwU9Vou4tHLcuDWhcS1bLxz+kB9Qtk6vgHiQcD
         SwBlMQcX0YXhLcA+IQJzi9IOPjU3wYnQnXIGCN24tIjqG3iWsfFD2UPxgxvkxTMKL3bp
         Wu2vOwTrqhYmor6jZm8CXxO3klBZnJuC9d0Ijzky9nAoZziH/rZbJA1tb5XRdljpnCh8
         j2XXW8HvFV45z5r18zAVa9Yu3YT3L3T7zc/qwHR/K2VluhTfmOPyWsuMFM9GaDQHz33F
         fKp8qco2JTlkMcWDwmkqvhlWE530OJxJbrGYRPdzM8kbbWILyMvHnqso1C2OAMHkcs0X
         dQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MXGKdXgV6wJNdOluiYAUCg/NRvd9faNoK+7jU+DVzqk=;
        b=pcwg7ChE6urKIL5KJBgy7q5bD8C+EOE8IYdVaoSwtcbSAlxBdYsngVp+BgV15UxEYi
         LxOL1T0Ye11uetMiiThI8XNlpyz+sqa27Q+Z29vSzNULMCmqwF4jaJj2i0pCDgTOIRFK
         EYTg99EmAofZ3Oe8ViJbNJ17b8IhkXhFN5t6vegiLCR7iVWSnPSGa3MaSH+Z89dMaYvC
         rtEr3E6OWDqNIUbXukcvSAIbEjbWy4xNMCFe4k651vvvEwwNIq+N3gdAF+uu7vxyYL4f
         Wn0/1d4Xd5StIDF3iDFG9RZoDTMUN7/keAHc+wyXxyZI3A4hxNwfCOCkQh+LAkGnP9Cg
         MyrQ==
X-Gm-Message-State: AOAM532WcE6dDGRRgxZfxQRChZvq/vedUsM++Y45gJoo6eY19/CGK/z/
        gNpBM24XySZZhvxIfOLv8healw497ZY/MA==
X-Google-Smtp-Source: ABdhPJwmoeodaZBffOtccmlvSqtW+C51oDiN8MyiPoTDI3KxZKhUamXFx7KA1ZkChCf4FdzD6hdgjg==
X-Received: by 2002:a5d:8752:: with SMTP id k18mr6616050iol.27.1602173768672;
        Thu, 08 Oct 2020 09:16:08 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id j3sm610362ilc.25.2020.10.08.09.16.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 09:16:07 -0700 (PDT)
Subject: Re: [RESEND^2 PATCH v3 0/3] Clean up and fix error handling in DIO
To:     Jan Kara <jack@suse.cz>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        kernel@collabora.com
References: <20201008062620.2928326-1-krisman@collabora.com>
 <20201008093213.GB3486@quack2.suse.cz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b8e122ef-d36b-c107-dae6-29fce6a69e26@kernel.dk>
Date:   Thu, 8 Oct 2020 10:16:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201008093213.GB3486@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/8/20 3:32 AM, Jan Kara wrote:
> On Thu 08-10-20 02:26:17, Gabriel Krisman Bertazi wrote:
>> Hi,
>>
>> Given the proximity of the merge window and since I haven't seen it pop
>> up in any of the trees, and considering it is reviewed and fixes a bug
>> for us, I'm trying another resend for this so it can get picked up in
>> time for 5.10.
>>
>> Jan, thanks again for the review and sorry for the noise but is there
>> any one else that should be looking at this?
> 
> If you can't catch attention of Al Viro, then Jens Axboe is sometimes
> merging direct IO fixes as well through his tree. Added to CC. If that
> doesn't work out, I can also take the changes through my tree and send them
> to Linus in a separate pull request...

For this case, probably best if you take it, Jan. I looked over the
patches and they look good to me, feel free to add:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

