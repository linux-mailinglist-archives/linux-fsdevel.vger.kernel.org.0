Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BAF6FBB21
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 00:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbjEHWpU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 May 2023 18:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjEHWpT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 May 2023 18:45:19 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B9A7AB0;
        Mon,  8 May 2023 15:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Gq6D7L47RtdyebzKe33l+EIiTTRSb6YOvwr3VpemPMU=; b=msEGK6+zszt/WI2OhmshzxJGHz
        UHj1IXOnjbisIFaqeK+lN1B7fONUAHGntP8rzba/qHK5e83BnbLD4ibjGKVWkhXBKO157ItL7CeRd
        fv9eM/jQPZtiHpJTCA0B1qi6/WzneeYHxgomqWDelCdx8xrt/ogQ03G3cG7W5o1V8SD9KdlXMwOr4
        BgdMZFeft3YhvGDs9fkDPpZvozI7zyW7NJn6pH8CjsnEJ5uLKgMsv25m8j5hzlh3ut7PfsF4l0an1
        817Ikt9AEncgVnIq3OXoCj083gNcr5IytPW4XpRDNNT7p3bkZdt+4UZTZNf0wMXA98E1ro0oLRDXM
        a9mm996Q==;
Received: from [177.189.3.64] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1pw9bR-004H1F-Eb; Tue, 09 May 2023 00:45:09 +0200
Message-ID: <53d57890-b655-1f14-5536-95311ee68118@igalia.com>
Date:   Mon, 8 May 2023 19:45:03 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/2] Supporting same fsid filesystems mounting on btrfs
To:     Dave Chinner <david@fromorbit.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, kernel@gpiccoli.net,
        kernel-dev@igalia.com, vivek@collabora.com,
        ludovico.denittis@collabora.com, johns@valvesoftware.com
References: <20230504170708.787361-1-gpiccoli@igalia.com>
 <20230507231011.GC2651828@dread.disaster.area>
Content-Language: en-US
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20230507231011.GC2651828@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/05/2023 20:10, Dave Chinner wrote:
> [...]
> So how does this work if someone needs to mount 3 copies of the same
> filesystem at the same time?
> 
> On XFS, we have the "nouuid" mount option which skips the duplicate
> UUID checking done at mount time so that multiple snapshots or
> images of the same filesystem can be mounted at the same time. This
> means we don't get the same filesystem mounted by accident, but also
> allows all the cases we know about where multiple versions of the
> filesystem need to be mounted at the same time.
> 
> I know, fs UUIDs are used differently in btrfs vs XFS, but it would
> be nice for users if filesystems shared the same interfaces for
> doing the same sort of management operations...
> 
> Cheers,
> 
> Dave.

Hi Dave, thanks for the information / suggestion.

I see no reason for the virtual_fsid fails with 3 or more devices; the
idea is that it creates random fsids for the every device in which you
mount with the flag, so shouldn't be a problem.

Of course renaming to "nouuid" would be completely fine (at least for
me) to keep consistency among filesystems; the only question that
remains is if we should go with a mount option or the compat_ro flag as
strongly suggest by Qu.

Cheers,


Guilherme
