Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744114BDCDB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Feb 2022 18:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347008AbiBUJDP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Feb 2022 04:03:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347380AbiBUJBS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:01:18 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7D727FDF
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Feb 2022 00:56:24 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id p9so25706129wra.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Feb 2022 00:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=algolia.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t4j70Shc7XavmIU28ZXBZ9YZLZ3H8F9NgtPdi+WU9Pg=;
        b=Ppn5EDMv7pYT8ehjg4mnj9/VIrvBAAOOL1nIM3N+UEN0qDpZsfeWTx2i/0p9JL1cjD
         M37IK5hH8QhrRRh+yNghRtLijtjAvbyWZ9AapuVTC+5fHBqZNbI84GkKROwWzGgwO8Xr
         Obai8J2YeoujiXGzEDCkxDjvC/7CWnxlFkq10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t4j70Shc7XavmIU28ZXBZ9YZLZ3H8F9NgtPdi+WU9Pg=;
        b=19rXiPTD4EXMnqEZVqpqTacaTAH2+Dzg+7CvnzbO6WwWVbROTodfH0yNEcMNhnzm3E
         Z8462jY1KIWvsDehrZ0xHkQ2LE8/EK2f69mrE/+vMY7DKknnD6SyHf7UzRvTaNaJnCVE
         iwZDFS1NRkDO+xWG/cW5KwyX9CFJ/PQGSI17C/8rEgCB4pXxCMYGPns9MyrrKCfm/Xwp
         0Hrd2pajULhxH2xeJJgDBky7XQwBzXifcB/gtPn8vQSZ4g+KCyuqeKC/8CrCxezRVwS6
         XjtU8Q/wIFWyyYRtrOnFR/mBae1XEHaBQsP6SKyuXBKLTjdQJguZFLFReiNH8HBgYlZb
         WcKA==
X-Gm-Message-State: AOAM530ib2yeAKJNJ6rX7X8bYgkD1QG51MTy22TfCJ548/VyYBn7DfcD
        xvq5o75HRMZj+CCvwl2RN73K5AtOYrlppg==
X-Google-Smtp-Source: ABdhPJwqYYgR9mHtDuZeuOTLDgUT8fgAJB8uagLZRIA3DRk3n7OpAxMVCFHOR6HflCfNNfz1zyJKmw==
X-Received: by 2002:adf:ef4b:0:b0:1e4:acd7:92da with SMTP id c11-20020adfef4b000000b001e4acd792damr15041648wrp.293.1645433772388;
        Mon, 21 Feb 2022 00:56:12 -0800 (PST)
Received: from xavier-xps ([2a01:e0a:830:d971:a8a3:7a18:7fc0:8070])
        by smtp.gmail.com with ESMTPSA id d2sm21156964wro.49.2022.02.21.00.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 00:56:11 -0800 (PST)
Date:   Mon, 21 Feb 2022 09:56:10 +0100
From:   Xavier Roche <xavier.roche@algolia.com>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] vfs: fix link vs. rename race
Message-ID: <20220221085610.GA332661@xavier-xps>
References: <20220221082002.508392-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221082002.508392-1-mszeredi@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 21, 2022 at 09:20:02AM +0100, Miklos Szeredi wrote:
> This patch introduces a global rw_semaphore that is locked for read in
> rename and for write in link.  To prevent excessive contention, do not take
> the lock in link on the first try.  If the source of the link was found to
> be unlinked, then retry with the lock held.

Tested-by: Xavier Roche <xavier.roche@algolia.com>

Revalidated patch (on a 5.16.5) using previous torture test;
- on ext4 filesystem
- on a cryptfs volume
