Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364F44BBA04
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 14:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbiBRNWo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Feb 2022 08:22:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiBRNWn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Feb 2022 08:22:43 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5A225B2E9;
        Fri, 18 Feb 2022 05:22:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B78401F37E;
        Fri, 18 Feb 2022 13:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645190545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w6dEtUbO74rabZakzEkx5M2xFsfVYKjEzrV618E92yw=;
        b=i/yXk1bsqvVmPVfnfIyWU4VIatLqXL3hbgMzDAtC7V7Nkf7Xzt1quey+oR3fvh1FCOxrF5
        8/ifOr06aM5OoJ1L25YKokFhD3h+ocjoa+ftOzke+G0tojJ70qxPHvDic5RHP1iJ2eGU/i
        udoI6MolrDrQVb7WIjfmExzHWycnWhA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5BFC913C8A;
        Fri, 18 Feb 2022 13:22:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OdmwEpGdD2JwYwAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 18 Feb 2022 13:22:25 +0000
Message-ID: <23e05520-43d7-f975-bb12-6bd148274a1a@suse.com>
Date:   Fri, 18 Feb 2022 15:22:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] fs: allow cross-vfsmount reflink/dedupe
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, viro@ZenIV.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <67ae4c62a4749ae6870c452d1b458cc5f48b8263.1645042835.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <67ae4c62a4749ae6870c452d1b458cc5f48b8263.1645042835.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 16.02.22 г. 22:21 ч., Josef Bacik wrote:
> Currently we disallow reflink and dedupe if the two files aren't on the
> same vfsmount.  However we really only need to disallow it if they're
> not on the same super block.  It is very common for btrfs to have a main
> subvolume that is mounted and then different subvolumes mounted at
> different locations.  It's allowed to reflink between these volumes, but
> the vfsmount check disallows this.  Instead fix dedupe to check for the
> same superblock, and simply remove the vfsmount check for reflink as it
> already does the superblock check.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
