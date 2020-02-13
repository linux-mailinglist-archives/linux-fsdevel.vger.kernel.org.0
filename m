Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E669F15CB78
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 20:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbgBMT4Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 14:56:25 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:47082 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbgBMT4Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 14:56:24 -0500
Received: by mail-pl1-f194.google.com with SMTP id y8so2742832pll.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Feb 2020 11:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K41rHHi78NH7LfnbsNtGm7/8ce/4IeglCRKrQ/Gun8E=;
        b=mGgyARF6j4JPeSWqZxDivC8f2Bi2TUaNW5xImU+P17YbZar4epuTICYd3DSr86v6xH
         He1Aspypu9/OJweMih2DAl7pB+FxVJ7DPh9QY+Cy2l91KF671ldihRa0g6HWEDFVB8d0
         SeI5ZnvFqaxyZkju8z+X2BAlHzhMnag2dKMZ6+Mo8jKoF+3bBB899DpogsKcLKyngv+a
         C/62F61mBQrmg8gc3L/I6j7/NhLs/Go+w5ZL+lQsAnY/+spahuttFBC2RzEKL7/g4EyB
         r2M9AK4CjhNrrfmcX1bXe0KArh0ELjdm1Izb4gwEgd5+i1PekqHbNF+LXit3G3S9lt6a
         37gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K41rHHi78NH7LfnbsNtGm7/8ce/4IeglCRKrQ/Gun8E=;
        b=lrBVf3Q6t027m9OR75vgAT9xWOWrwYLipBiM705C0wNffj8y+XZxfeBBgveQvF6B4L
         /6JeCYpJ9+fIGJdM5/IN858bOhQCmtZOlmSkq8NHHc80Q0nOjmr+b57X8Tjeu2Z/npPG
         zLvWz+PRncCtqPLL/cs+szQmt+D19DKm943QNwug3SDsSuS+t4zAThVPoyBqXoyWBSkh
         Uh6QBOleDPreG0lQ1CG5gk9ZQVKEwKGfglSpRyDbsUgAiE5ifRdIjd6kYsecGU+4M1gk
         llPFnK7I1ouMjL4X6qZmzocUJ+6vZG8ukaGX2x8Js28UrjHAaxK7xbW1vSfqyBmwyyYY
         lXww==
X-Gm-Message-State: APjAAAX3pBRkRHgCc3o2fkmmP9PWbZAQBezR6Z2lA/lq0aKcHefYSPxE
        zu5gDXtppflx2yC2zubwfXaZOpI1vSM=
X-Google-Smtp-Source: APXvYqxyKzKrO2rp0oGEAYSrfeFdE5J8xB9bW0kGRxwWOaZa0TqvQmV+CK5qur4xkVDni04K5c06hA==
X-Received: by 2002:a17:902:8d8d:: with SMTP id v13mr15280086plo.260.1581623782574;
        Thu, 13 Feb 2020 11:56:22 -0800 (PST)
Received: from ?IPv6:2620:10d:c085:21cf::1150? ([2620:10d:c090:400::5:249c])
        by smtp.gmail.com with ESMTPSA id g72sm4317874pfb.11.2020.02.13.11.56.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2020 11:56:21 -0800 (PST)
Subject: Re: [PATCH v2 12/21] btrfs: move hint_byte into find_free_extent_ctl
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
 <20200212072048.629856-13-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <c883e3b8-246b-b5a2-6aad-405759755648@toxicpanda.com>
Date:   Thu, 13 Feb 2020 14:56:18 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200212072048.629856-13-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/12/20 2:20 AM, Naohiro Aota wrote:
> This commit moves hint_byte into find_free_extent_ctl, so that we can
> modify the hint_byte in the other functions. This will help us split
> find_free_extent further. This commit also renames the function argument
> "hint_byte" to "hint_byte_orig" to avoid misuse.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
