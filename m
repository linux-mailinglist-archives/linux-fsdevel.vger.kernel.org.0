Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2ED56F8680
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 18:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjEEQTH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 12:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjEEQTG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 12:19:06 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593B417FE2;
        Fri,  5 May 2023 09:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nHS51KuYKk057aMK+NYgGkFiUtZjS9hiua+Pgmo6TmY=; b=DnIcJb+H2eP9cAqeflqllmkE6a
        KVgJBQrnUhnbcW9eS1SmF7y+MfABkA/iPSQErbjEyFquNrVIqMIZndPr1iegXe5eIR34Yi35MuQ2q
        H6bnPmO88kbOcyBtqqnHh/BOTyT73uKDzkeNb1ySntARZO1UpnEk3hRc3XNQnh7WWHgHHZ93OzSWi
        7M67M209b9dBqDisteMydc6yJap/g+1ZAiSKU51Nnk3Q6H/YrHV+39ggNYfut4mQR+wYUOFEVZm8U
        UZpblVv7mgNLZsXJ5jEuo4gUJodh+z+OEhpg2AZDHxSZ4vnkceIyOLRTqNRuZwEEuPLa4qJDv3ltk
        PchN3QcQ==;
Received: from [177.189.3.64] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1puy97-001xZC-D5; Fri, 05 May 2023 18:19:01 +0200
Message-ID: <a28b9ff4-c16c-b9ba-8b4b-a00252c32857@igalia.com>
Date:   Fri, 5 May 2023 13:18:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] btrfs: Introduce the virtual_fsid feature
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-fsdevel@vger.kernel.org,
        kernel@gpiccoli.net, kernel-dev@igalia.com, vivek@collabora.com,
        ludovico.denittis@collabora.com, johns@valvesoftware.com,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <20230504170708.787361-1-gpiccoli@igalia.com>
 <20230504170708.787361-2-gpiccoli@igalia.com>
 <20230505131825.GN6373@twin.jikos.cz>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20230505131825.GN6373@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 05/05/2023 10:18, David Sterba wrote:
> [...]
> Have you evaluated if the metadata_uuid could be used for that? It is
> stored on the filesystem image, but could you adapt the usecase to set
> the UUID before mount manually (in tooling)?
> 
> The metadata_uuid is lightweight and meant to change the appearance of
> the fs regarding uuids, verly close to what you describe. Adding yet
> another uuid does not seem right so I'm first asking if and in what way
> the metadata_uuid could be extended.

Hi David, thanks for your suggestion!

It might be possible, it seems a valid suggestion. But worth notice that
we cannot modify the FS at all. That's why I've implemented the feature
in a way it "fakes" the fsid for the driver, as a mount option, but
nothing changes in the FS.

The images on Deck are read-only. So, by using the metadata_uuid purely,
can we mount 2 identical images at the same time *not modifying* the
filesystem in any way? If it's possible, then we have only to implement
the skip scanning idea from Qu in the other thread (or else ioclt scans
would prevent mounting them).

Cheers,


Guilherme
