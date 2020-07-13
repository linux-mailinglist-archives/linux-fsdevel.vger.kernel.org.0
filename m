Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA75C21DDC8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 18:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbgGMQpd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 12:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729703AbgGMQpd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 12:45:33 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18116C061794
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2020 09:45:33 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id bm28so12271044edb.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2020 09:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YWJmchy5NBOUhyK5SwRwLbF2VzgzDqorZLs7Z4tlH84=;
        b=YauW5eu+U1WcnMWUhCH6USIo4RRa/4DjiT3BOcbbsGW0KeXV1YoHALoYmdaAuDYylQ
         xW3zY6dlDd+ktaWQENSLYYleqAJBN1mwxzFTHYSZhqqCbzDPkHsybQCD9Ue2e1XZtlDx
         VqnuSpVjTEL1T5Bs9LKIoi7gvVEmFp1gABikk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YWJmchy5NBOUhyK5SwRwLbF2VzgzDqorZLs7Z4tlH84=;
        b=kfqHscCAvMj4PrU8TBm6MtpZEcGM5OLIbgr74vwbP8nXt/SDTTtdWpUG/iX1PYnN4x
         cOuAtdvCLCgMfisSWzw8a3FbPvrJClRP1z/VGTRLYmSA8gYtNmr/VjjlJPFlGcraD1OO
         /GR8XNfU1RNUkOEXHu7bKhwiB/Nb/2nR8KCOXcNbpuo2/8OBJOIrWO4K6wc3H3CwNZOo
         k9A3NIl4voTg4pvrgEAjjh1ah0pzxCbW1bqhjNluRJpPtcPsO0+/e9u6SqDhs0+T9b3V
         ZCxTQnKRZdjyHD6x9gjvoBn3ENYbDoU2xJo5XT5WyZODO6XpCZh1n9OLG9OAg5GZGFPJ
         4mWw==
X-Gm-Message-State: AOAM532FdMknZjzBYPyMdQNGZKJbkZRlXrthPgw7cZ17bMRumzMOaA4Y
        1HJz9p7tnasNFuu84JZtuP6gGA==
X-Google-Smtp-Source: ABdhPJzcKhMEWkxja+nXz5D6veGVU3r4UEuSD2r7Zl/utZcyhS3svSDQ5ap7tYvz3qxodpWBKIGFLQ==
X-Received: by 2002:a50:fd12:: with SMTP id i18mr256850eds.371.1594658731595;
        Mon, 13 Jul 2020 09:45:31 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:ef88])
        by smtp.gmail.com with ESMTPSA id s7sm12186223edr.57.2020.07.13.09.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 09:45:31 -0700 (PDT)
Date:   Mon, 13 Jul 2020 17:45:30 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v6 1/2] tmpfs: Per-superblock i_ino support
Message-ID: <20200713164530.GB1065134@chrisdown.name>
References: <cover.1594656618.git.chris@chrisdown.name>
 <2cddd4498ba1db1c7a3831d47b9db0d063746a3b.1594656618.git.chris@chrisdown.name>
 <20200713164145.GY12769@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200713164145.GY12769@casper.infradead.org>
User-Agent: Mutt/1.14.5 (2020-06-23)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox writes:
>I don't think that works.  I think you meant to write ~(SHMEM_INO_BATCH - 1).
>Or just ino % SHMEM_INO_BATCH which works even for non-power-of-two.

Er, right. I now wonder why I didn't just write `ino % SHMEM_INO_BATCH` :-)

I'll send again with that fix.
