Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA1232DD970
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 20:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbgLQThj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 14:37:39 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:3382 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729069AbgLQThj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 14:37:39 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fdbb35a0000>; Thu, 17 Dec 2020 11:36:58 -0800
Received: from [10.2.61.104] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 17 Dec
 2020 19:36:58 +0000
Subject: Re: [PATCH 18/25] btrfs: Use readahead_batch_length
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20201216182335.27227-1-willy@infradead.org>
 <20201216182335.27227-19-willy@infradead.org>
 <a5b979d7-1086-fe6c-6e82-f20ecb56d24c@nvidia.com>
 <20201217121246.GD15600@casper.infradead.org>
 <20201217134253.GE15600@casper.infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <e36468d6-8944-5fee-fe48-4f8cf4f2f679@nvidia.com>
Date:   Thu, 17 Dec 2020 11:36:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <20201217134253.GE15600@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1608233818; bh=6rL5WMauA8+LXyGXmzjXvOTi9WOgrRuLBi9GxeFHQwQ=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=HLEYh7m+YH14H3re5sfCCvg1KTEdsatWYftLMwpfepT3/eYkHw3P3Eq4rb0XgKmqZ
         LVFaBzKsGC26TSljIlKDxVNpKYsW1woSLuiA6iTXMp/QIa8NZi+ywUTtcm9BAkQC/s
         8XHmXqz8Rb4h7gD6Kq8Cf1krkdXne6HSCxr38AlWn/OTts/nXkmfe4/abBzoNF7asE
         KW8knZ0bTpYRM00SzLYZl7SvfCIe4mc70RKN8pk3wfETmtcGHSqiPmQNx2gz1qG/Nc
         uQmsDgx4lszWHKwxqGa9s0O7yH6k6qWxr2PhzinE0v0c1HtFalpUHoD5Rv3N1zf37U
         wFuZozwfh4vBA==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/17/20 5:42 AM, Matthew Wilcox wrote:
> On Thu, Dec 17, 2020 at 12:12:46PM +0000, Matthew Wilcox wrote:
>> ehh ... probably an off-by-one.  Does subtracting 1 from contig_end fix it?
>> I'll spool up a test VM shortly and try it out.
> 
> Yes, this fixed it:
> 
> -               u64 contig_end = contig_start + readahead_batch_length(rac);
> +               u64 contig_end = contig_start + readahead_batch_length(rac) - 1;
> 

Yes, confirmed on my end, too.

thanks,
-- 
John Hubbard
NVIDIA
