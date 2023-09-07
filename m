Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DD2797B2C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 20:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238562AbjIGSGm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 14:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjIGSGl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:06:41 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2FAB2;
        Thu,  7 Sep 2023 11:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GLt6I0eIh/tojvnC8DYHnIYamgExtb9nbRvfiuRFFTY=; b=RysfinjDsNJuCgNxjY0CFbC8c2
        oShALx+JaQNiA51r8caS7BW2M0U/6bgW/fsY3GBb4b7EnVK6VWoVfmDLSXYG7eMOZ3FGLwy9ne6zW
        VKKit+Iioik4QPJ3lsQwmxLMLiJKeeJ/RNts85qwFgfpbJmmXdL7J42/ENIZeDlnt4p93l/sgj2R+
        +SY1+QI8sc5q2nfueCQnBeeCCPhdjEibiiT+fUjsdENT7FEaxeTQ1oCmCAFyYs+Jz/Bmb3fmHFTqS
        4xFUHALP7hvGD87Sfx0HHQWEQ2NMOIqqMNRRjZG9RfGvnxfQZbPkDLZmaAEUO2Xa1qSJGdfsnFjT/
        KyY8ZZCg==;
Received: from [179.232.147.2] (helo=[192.168.0.5])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qeGbz-000YEh-RC; Thu, 07 Sep 2023 17:08:03 +0200
Message-ID: <4de784ec-2277-0793-0a2e-cc5a94eeee3b@igalia.com>
Date:   Thu, 7 Sep 2023 12:07:55 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH V3 2/2] btrfs: Introduce the single-dev feature
Content-Language: en-US
To:     dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        josef@toxicpanda.com
Cc:     linux-btrfs@vger.kernel.org, clm@fb.com, dsterba@suse.com,
        linux-fsdevel@vger.kernel.org, kernel@gpiccoli.net,
        kernel-dev@igalia.com, david@fromorbit.com, kreijack@libero.it,
        johns@valvesoftware.com, ludovico.denittis@collabora.com,
        quwenruo.btrfs@gmx.com, wqu@suse.com, vivek@collabora.com
References: <20230831001544.3379273-1-gpiccoli@igalia.com>
 <20230831001544.3379273-3-gpiccoli@igalia.com>
 <20230905165041.GF14420@twin.jikos.cz>
 <5a9ca846-e72b-3ee1-f163-dd9765b3b62e@igalia.com>
 <fe879df8-c493-e959-0f45-6a3621c128e7@oracle.com>
 <20230907135503.GO3159@twin.jikos.cz>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20230907135503.GO3159@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/09/2023 10:55, David Sterba wrote:
> [...]
>> virtual-fsid is good.
>> or
>> random-fsid
> 
> I'm thinking about something that would be closer to how the devices'
> uuids can be duplicated, so cloned_fsid or duplicate_fsid/dup_fsid.
> Virtual can be anything, random sounds too random.
> 

same-fsid maybe? I could go with any of them, up to you / Josef =)
