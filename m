Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A09742743F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Sep 2020 16:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgIVORL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 10:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgIVORL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 10:17:11 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1675EC061755
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2020 07:17:11 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id q5so19166273qkc.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2020 07:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IF/VeFlQWv+XOsjueScQCMEysjJ4rjkdCkDflKceYao=;
        b=s71nT25ioisAEiIG8/0Q5VC2l/TcsaRH9Fdtr6GiSJTAs538himWdVQwLFsxzSpUGf
         61RsWwqTfT/7XsNXXWxOmq1EkqiF2XJgaJvYJM2JghFPepIcPQeLPx3roaZ2WIV9rpGg
         kguPrBr95fSCWcmqS1Pms+vWVQH5IyY1LRHNhBUsUbXZ9tv1Z0kTFKk0VkLp7YyO9Es6
         C6upSQNR5mlI639KTjezjWmJFmKihpY/9cc6bCwLldld4/86GeGxOzhV9KooVJvasVw6
         nfd49Obf4DWeDqpNA/GGd0sYNJVrxsrUqD89Rh37qgH3Jrt+I5PbaGItjAD2Cl2RjpW7
         6aWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IF/VeFlQWv+XOsjueScQCMEysjJ4rjkdCkDflKceYao=;
        b=FkFld5Vp4HTzi3W0ueSAiBJBBMK9Nzxv14GK7S88zV43uNKcGiOKGewlBtIPe25pNX
         7upP2Q0wdrIAuXJo8QMAtXEW6e4mZBXtE48IC5PFzPMMahRiVJoE1SXruFGopYD8PC64
         203uNHWrJG8q/rkgaaMCr2og/j2EW533A+5wXa3/3UI3I1NYJo1YajTyExxiQRFlA1xC
         OP9khlVfQUZyNCBbcAgshnCtJXERQHGxOLmS9NY03aj2+WEpVkNDnnXM4lDnrxv5bUM9
         0qpGiyovrpbOE9+uf5YLXo+omxmyYeDO/pUaEcshr4PpPLB48oToSeHpHPsvfvQZgH13
         WLtw==
X-Gm-Message-State: AOAM533uzD7h66WqJ2JjycNy63IcaeLqO5ltsITnNDYY2Ih18bseoxe6
        xR5PJIEZrUUXEd5aMwB48OdR/A==
X-Google-Smtp-Source: ABdhPJziGkDMVn4JtwXN/Cq2Ds2exGSBUy4/ZrJ8byUA1LgIujCyqJjOQLEPkWeHeU+Vp0HKNKsa7A==
X-Received: by 2002:a37:545:: with SMTP id 66mr4854742qkf.338.1600784230218;
        Tue, 22 Sep 2020 07:17:10 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q7sm13017061qte.95.2020.09.22.07.17.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 07:17:09 -0700 (PDT)
Subject: Re: [PATCH 01/15] fs: remove dio_end_io()
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        johannes.thumshirn@wdc.com, dsterba@suse.com,
        darrick.wong@oracle.com, Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
References: <20200921144353.31319-1-rgoldwyn@suse.de>
 <20200921144353.31319-2-rgoldwyn@suse.de>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <8372f830-6a0d-b88b-fbd7-de90b0996269@toxicpanda.com>
Date:   Tue, 22 Sep 2020 10:17:08 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200921144353.31319-2-rgoldwyn@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/21/20 10:43 AM, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Since we removed the last user of dio_end_io(), remove the helper
> function dio_end_io().
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
