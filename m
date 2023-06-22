Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C528A73A3B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 16:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjFVOxl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jun 2023 10:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbjFVOxf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:53:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0887F1996;
        Thu, 22 Jun 2023 07:53:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A90F421E02;
        Thu, 22 Jun 2023 14:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687445606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZQ3M1L1RSqVm2MyuTa4Yvo8YEEMygwWogDC8ahfHfNI=;
        b=2owPffEDM1iWz8CdazqjHy3AxJwGsYxlZ/+Yu6QxT8lvwEyn3YIeSbOY0yI3awkLbxaQdW
        HukONKfPUiwfPgQxBnupzVK2Jrf64g9NYFm97ZaEaq2iZWVoDl76nKahT+/qS1IuVFo23d
        TeekWSDBLq+2AtU2kusUiFeopHoXy3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687445606;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZQ3M1L1RSqVm2MyuTa4Yvo8YEEMygwWogDC8ahfHfNI=;
        b=7qmzsmLYYk2NVw1wMGtpHBWQOSu1V6A2Uv1zH9sP8UFUndexvPNSZb0b+10dVOMyxbb72u
        ceanv5+68xTC81DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 53B7213905;
        Thu, 22 Jun 2023 14:53:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aD+2E2ZglGS3JAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 22 Jun 2023 14:53:26 +0000
Message-ID: <f90772f6-11fe-0d8a-7b1c-d630b884d775@suse.cz>
Date:   Thu, 22 Jun 2023 16:53:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 29/29] mm: shrinker: move shrinker-related code into a
 separate file
Content-Language: en-US
To:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        david@fromorbit.com, tkhai@ya.ru, roman.gushchin@linux.dev,
        djwong@kernel.org, brauner@kernel.org, paulmck@kernel.org,
        tytso@mit.edu
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, dm-devel@redhat.com,
        linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <20230622085335.77010-1-zhengqi.arch@bytedance.com>
 <20230622085335.77010-30-zhengqi.arch@bytedance.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230622085335.77010-30-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/22/23 10:53, Qi Zheng wrote:
> The mm/vmscan.c file is too large, so separate the shrinker-related
> code from it into a separate file. No functional changes.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Maybe do this move as patch 01 so the further changes are done in the new
file already?

