Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4A6D15499E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 17:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbgBFQre (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 11:47:34 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36782 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgBFQre (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 11:47:34 -0500
Received: by mail-qk1-f195.google.com with SMTP id w25so6195484qki.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Feb 2020 08:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XVG7v7bFBwwbQl9cPUzkj8ZxgF7lAxk5feqnNAL3RXk=;
        b=h22xUsnhdJsrHQwryenL7/L3SoNeXvRgwKddh8PQMgu/wTgMa5CdwETMJgD8ChbneF
         /yagSixq+jvAQ654XS6xNeqA5uTc24ZuUD5TrYGeUn/fi1c8zt5BRPgSXrvW7ujIbiVs
         Dmdk3ZSMJJSwv+glIUG34SHYUxx5n12Bn1nE1mY48Qy8c2kqd37XM17Ma5bQ+ZxscJr+
         h41Q2zoy/C65WfjgLEpP44XsVt6KzepfBuAQu9w6nbyK+MXEBRBpns9P7+mmO4zZwKLU
         m0mqbJ951DWiuDcm5TgoBNfgzcjgVEQc0PC5UR+P/bytiyvh17aVVntXBU6ivz/bKQ1b
         cjNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XVG7v7bFBwwbQl9cPUzkj8ZxgF7lAxk5feqnNAL3RXk=;
        b=FM1cA3wpBxG0HZz8DtgwO4ctWDmOts04VxZGOvbJJCTzFp3rJ6b8QjtBAMKiejYP7e
         GXVpxq11HMTdqoPNCnxaXCQmCWNW8mcxlt2PEW14XCMk5eyZTdrDmP1zk24yxoOSZo9d
         89qUXZW+YBOcu4vL1vS0CFtQtSVUPcVyL8zdJ1UsBXF+7N5sC7V+nqqY1SOvjFcDNnBe
         6FaTnb17PhZ/AxfMCLSx/R+sNWq6icBk60cOFK7vsMSf5loldTzqROvp9Cu3DbOPeSBl
         cLaSc3hR09SAz6LJYbLUkYGMpqOCeQYPNhKiJxpWY9demhmHBKw4ZHNdxG4A67Q2aRV/
         IKSQ==
X-Gm-Message-State: APjAAAW1T7wGVfJYrcDo+fFsMtGBMVGlL8tIYwQTKfd5ze2p1yWoPw4v
        x4WZc+RKCxSPIkDXuEoWIOXe1eyeuIo=
X-Google-Smtp-Source: APXvYqxQTyFqJidCnScxft9PkR13gGGGB9EIMlccweOwemtfo1yKROui489TylByINemsvoatYOlGg==
X-Received: by 2002:a05:620a:20d4:: with SMTP id f20mr3068975qka.343.1581007651823;
        Thu, 06 Feb 2020 08:47:31 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id w21sm2012878qth.17.2020.02.06.08.47.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 08:47:31 -0800 (PST)
Subject: Re: [PATCH 07/20] btrfs: factor out decide_stripe_size()
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20200206104214.400857-1-naohiro.aota@wdc.com>
 <20200206104214.400857-8-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <36283c9f-48da-7daa-3167-1efe9e64c66f@toxicpanda.com>
Date:   Thu, 6 Feb 2020 11:47:30 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200206104214.400857-8-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/6/20 5:42 AM, Naohiro Aota wrote:
> Factor out decide_stripe_size() from __btrfs_alloc_chunk(). This function
> calculates the actual stripe size to allocate. decide_stripe_size() handles
> the common case to round down the 'ndevs' to 'devs_increment' and check the
> upper and lower limitation of 'ndevs'. decide_stripe_size_regular() decides
> the size of a stripe and the size of a chunk. The policy is to maximize the
> number of stripes.
> 
> This commit has no functional changes.
> 
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
