Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96BAECFEF5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 18:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbfJHQdU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 12:33:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58628 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbfJHQdU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 12:33:20 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 828338665A
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Oct 2019 16:33:19 +0000 (UTC)
Received: by mail-qk1-f197.google.com with SMTP id q80so19120609qke.22
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Oct 2019 09:33:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0emuj7ckCeOi2ShbRboaosDgyEFD8QY/GtdLIcv15Yo=;
        b=WTtKkSCVRdOWCTy6cocmhGzKrt/VJ2ZxYhnNNzw9bd5yEIhwj9YFqInwJRhoIVY49X
         u4KDRnXyzapQZIxklZVCR2gfM3P4BNB7MMmuThKOc0xCf6i6SP6bPoPMMBwCa4zLaMhU
         JQg2jDsFsjjt9vrBz4UJWTsVnpye7HHQ7Kk4QlXjXQ3ONuepSJpEyAa/tBiE5nkVfpAN
         1OsG8/Zy6KRJyKim0QdQM+FjcPnPESKJt77BLXp4Pl5b0O9aeYeejaDChxod1rPB17z9
         bRzRhzFJrwjWpOmp0/cAI8Mm5ah0nnp2nNLZXvJwshPybNRFEGmv+s41nSDFID3HqyzT
         DekQ==
X-Gm-Message-State: APjAAAUPhv1woCj46vxH9cp3ze/C/7mRWi4+UOKsOxziTE22qdwWF1pF
        erC1v/Bp6ve/PV6Gqj/51/3p1yTM6JJ5zSO5XCZgRRT8ISNKDGhXlitjjY7037Wqui0QM4fa8dz
        cK415+Noyarb31dYpDRP2TovgeA==
X-Received: by 2002:ac8:2966:: with SMTP id z35mr37722112qtz.348.1570552397038;
        Tue, 08 Oct 2019 09:33:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqygwcCLbNfX37PFFgvJBMHiAJ+4DIe1+sjK4nzF87cpY0peuIfCoM/lAQubKQGhuVDDY9RmBw==
X-Received: by 2002:ac8:2966:: with SMTP id z35mr37722061qtz.348.1570552396613;
        Tue, 08 Oct 2019 09:33:16 -0700 (PDT)
Received: from [192.168.1.157] (pool-96-235-39-235.pitbpa.fios.verizon.net. [96.235.39.235])
        by smtp.gmail.com with ESMTPSA id n192sm8999408qke.9.2019.10.08.09.33.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2019 09:33:15 -0700 (PDT)
Subject: Re: mount on tmpfs failing to parse context option
To:     Al Viro <viro@zeniv.linux.org.uk>, Hugh Dickins <hughd@google.com>
Cc:     David Howells <dhowells@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
References: <d5b67332-57b7-c19a-0462-f84d07ef1a16@redhat.com>
 <d7f83334-d731-b892-ee49-1065d64a4887@redhat.com>
 <alpine.LSU.2.11.1910071655060.4431@eggly.anvils>
 <20191008012622.GP26530@ZenIV.linux.org.uk>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <9349bbbe-31fe-2b0a-001d-2e22ee20c12f@redhat.com>
Date:   Tue, 8 Oct 2019 12:33:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191008012622.GP26530@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/7/19 9:26 PM, Al Viro wrote:
> On Mon, Oct 07, 2019 at 05:50:31PM -0700, Hugh Dickins wrote:
> 
> [sorry for being MIA - had been sick through the last week, just digging
> myself from under piles of mail; my apologies]
> 
>> (tmpfs, very tiresomely, supports a NUMA "mpol" mount option which can
>> have commas in it e.g "mpol=bind:0,2": which makes all its comma parsing
>> awkward.  I assume that where the new mount API commits bend over to
>> accommodate that peculiarity, they end up mishandling the comma in
>> the context string above.)
> 
> 	Dumber than that, I'm afraid.  mpol is the reason for having
> ->parse_monolithic() in the first place, all right, but the problem is
> simply the lack of security_sb_eat_lsm_opts() call in it.
> 
> 	Could you check if the following fixes that one?
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 0f7fd4a85db6..8dcc8d04cbaf 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -3482,6 +3482,12 @@ static int shmem_parse_options(struct fs_context *fc, void *data)
>   {
>   	char *options = data;
>   
> +	if (options) {
> +		int err = security_sb_eat_lsm_opts(options, &fc->security);
> +		if (err)
> +			return err;
> +	}
> +
>   	while (options != NULL) {
>   		char *this_char = options;
>   		for (;;) {
> 

Yes the reporter says that works.

Thanks,
Laura
