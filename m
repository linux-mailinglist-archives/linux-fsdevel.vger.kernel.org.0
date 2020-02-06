Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36D301548C2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 17:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgBFQDo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 11:03:44 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43404 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbgBFQDo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 11:03:44 -0500
Received: by mail-qk1-f194.google.com with SMTP id j20so6015353qka.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Feb 2020 08:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=auM1D6XkmuTWoAnI2coioQdaLdPF1YSkzr7zrBrEwas=;
        b=WQBoHKhC763PVLixj0hPEN8PIG6tDU+lgk97gN5E9kveHqzGwcUyLPMJJaqQjjZ6NS
         K/qnsr9C54SXr2jbVhNXChpXvTJkEawU3KJQNSHS/TKAMruUOUMnJmqkpHM++s775/Nq
         JULgUhrFsZ4BwPki+cJDeCzRSqQe4Xu7/DYulubjrCl8e24OQ/Z5DgdCV4heaUFD/hTH
         kPk52I0cf7DFUFh/7soSfkqcFpA491cxVInO4J2ayyM24xjdHylxpYoCc/0p2/f77DIt
         8BTOh/8MW6QbonKiCX3pz6b2LDYajZP8MLTK4CcvyMxl2UpuMpvFO9yfnkSHUd6xWOYf
         GuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=auM1D6XkmuTWoAnI2coioQdaLdPF1YSkzr7zrBrEwas=;
        b=AT2X+CaqPM7FDR27u6KdmXA2FrUEYTeaXgDr7RxDuHPAWCq1CUQt05T5QSttcdm6mC
         esEfhk4/L7coAoVcYfHlsPuKiiuWLlpvKOXXu+8Nnfhw4Za1c9/ZqwlC1Jhv/Y6j96oG
         N3prhrzm5/tJfxTmn6aJaaqa1X1f6dlJ5epCpZa1a00X44SiTHNElAaP7/18bYuDtmZd
         lspT3gIwj7CVcEjOPcgWcJxawFpH9MR3to3K+UEB/iWqvZrDIgjMtKfCNlNdTTELSsCi
         jW85Zbp39zQ0KSxXooJVDCaA3O8yEbdGnR8pnXwwl2EN/BWL5T3CSGJhpfzClVSF28Lo
         TQWg==
X-Gm-Message-State: APjAAAXs39a3+Ij3ORVX2KaY+WAr5f39U/o3FMcddl00S4weK5uMyQk0
        v7Lji1H7pD7X+KJWNPwYdVtPIRx3kB0=
X-Google-Smtp-Source: APXvYqzpVLG0Ivic4pzG3Bnusjsr/tgABOuEpIHdJh+WJ1iPZqfwSRq8tkcFe2M8rDrfTmb1K21vVA==
X-Received: by 2002:ae9:e306:: with SMTP id v6mr3163469qkf.162.1581005021680;
        Thu, 06 Feb 2020 08:03:41 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id s20sm1593316qkg.131.2020.02.06.08.03.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 08:03:40 -0800 (PST)
Subject: Re: [PATCH 01/20] btrfs: change type of full_search to bool
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20200206104214.400857-1-naohiro.aota@wdc.com>
 <20200206104214.400857-2-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <ea9e9901-c314-2f39-4802-716eb32eafcc@toxicpanda.com>
Date:   Thu, 6 Feb 2020 11:03:40 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200206104214.400857-2-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/6/20 5:41 AM, Naohiro Aota wrote:
> While the "full_search" variable defined in find_free_extent() is bool, but
> the full_search argument of find_free_extent_update_loop() is defined as
> int. Let's trivially fix the argument type.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
