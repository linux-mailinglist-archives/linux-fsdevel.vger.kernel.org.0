Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD6F6F5E89
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 20:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjECSuj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 14:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjECSu0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 14:50:26 -0400
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A8259F9;
        Wed,  3 May 2023 11:50:01 -0700 (PDT)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-64115e652eeso7200389b3a.0;
        Wed, 03 May 2023 11:50:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683139800; x=1685731800;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5FYuBoy706BNjZQW8G4Brm2K3CMMFujMy+1qdI/x7nE=;
        b=f/5Pm3fuK+SUBJ1KqY4XsCc7rM+zRqsH1mTszfjprKI6j7t23pMn1xaAqtgmCLjZDU
         yV4ngDG2moljs0LpJ3IHLcJW6hZqX73zQ31e3NtuUpHwI5P0g9dTj0u9fqWGKCHaGBwa
         SKmpdgj4+/A70XBhzfDPDQJlSuVZ1RbPuoK21SaQjh52YV1Q8FYAaktkoaECWkpSzBxZ
         fgsCEPLUJx0Bb0xL6y454XslUmEAorD7EDfSmddSi3VtOIjiPaqsq3DqmaAzSABRxr/f
         wFnjOqt7NPJw5GsRrPa32eXHTCImz/k0vSnDXy2ySvuT/2esUAGSYo0mzk/dfR9Zs2iw
         mw0A==
X-Gm-Message-State: AC+VfDwshLLZUuOgyR6sI78CZJMoh2d3nSOUAabzGq0KOJBmWWLle6Zm
        doAnhlrXK4kxyHd1chohWt8=
X-Google-Smtp-Source: ACHHUZ6klmcPoNpDdFKQ5xArJAJNygpTD6IHFf4dsBUkLvzbtXVUDRVlRebTNnMEFNkXvN71piNtKQ==
X-Received: by 2002:a05:6a20:12c4:b0:ee:cc76:5023 with SMTP id v4-20020a056a2012c400b000eecc765023mr3789944pzg.22.1683139799941;
        Wed, 03 May 2023 11:49:59 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:c683:a90b:5f41:5878? ([2620:15c:211:201:c683:a90b:5f41:5878])
        by smtp.gmail.com with ESMTPSA id t3-20020a056a00138300b006338e0a9728sm23946563pfg.109.2023.05.03.11.49.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 11:49:59 -0700 (PDT)
Message-ID: <ab663865-9099-8f6b-de1e-30c1356d5078@acm.org>
Date:   Wed, 3 May 2023 11:49:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH RFC 16/16] nvme: Support atomic writes
Content-Language: en-US
To:     John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jejb@linux.ibm.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com,
        Alan Adamson <alan.adamson@oracle.com>
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
 <20230503183821.1473305-17-john.g.garry@oracle.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230503183821.1473305-17-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/3/23 11:38, John Garry wrote:
> +			if (!(boundary & (boundary - 1))) {

Please use is_power_of_2() instead of open-coding it.

Thanks,

Bart.
