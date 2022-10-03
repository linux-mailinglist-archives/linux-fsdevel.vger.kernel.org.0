Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179535F2F00
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Oct 2022 12:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiJCKsk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Oct 2022 06:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiJCKsd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Oct 2022 06:48:33 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A516E50733;
        Mon,  3 Oct 2022 03:48:31 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id w2so9896184pfb.0;
        Mon, 03 Oct 2022 03:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:content-id:mime-version:references:in-reply-to:cc
         :to:subject:from:from:to:cc:subject:date;
        bh=kQUbyQZ45z3C7K2tcOxsIXOsm6gYJzfQJ0oUyErc9i4=;
        b=HCBm2L118tNM6BrPO9j7u1/+TlvhP03OqqHvCdI7lKtG4aZxtF0y4YnTfn89KSGBZk
         T/C7PbBgDDmt1C5gN7xq4m/3WwTyyPe/iUqa6ElaaLN6wmPLARBR9i93GjuM831FwnVX
         TKIfeVGrMjMqVLn+4f3+G6MGgJgk13u6+Af6xvJph6VTdZuXu61bDxIuyuJ0zlLOBZY7
         zQFz84+fYRWZO9Hlg1Ml9k4fJBVupuwdPmn9+9PQHjByPopcZTogONehL90K32UcjMwU
         JZJNqA7qbImxz5EH34oKxeE5blMAn/BHKo1n9ZB28JZNc505uBaqZ7mzrlmv8NZgARur
         /GDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:content-id:mime-version:references:in-reply-to:cc
         :to:subject:from:x-gm-message-state:from:to:cc:subject:date;
        bh=kQUbyQZ45z3C7K2tcOxsIXOsm6gYJzfQJ0oUyErc9i4=;
        b=b7w5ZeSKwUP6US5zBvIHf3NxBUJWrDeVpGI4eSsuU5Y5y+W3IQseO+N4lfDHphyR4d
         RpxkhFmoJCS4KMdjPAvlmvbCUciLJ6NkFY2n7I0NPj7715JxoLmQ/YRuESyYbywFhoGn
         PdIrFNDD/461rYk3/R33WQmxUKDMquToG1c2vwXXQgQ9/7Y8wRv69DZwnhY9BbDOOFcU
         DrI5ZKQeZ0tWoG11WEl/AOtpbJrb73W9iFXgQqYCMWESLPplTTZRYKpwGvyEDfWeZy8R
         4gG4/qrt0V7WyKD+aUYa/O5DMd5UKqn63RbKXJ+CAvbZBF7522M1vq01ENTtMkcjPNma
         j+uw==
X-Gm-Message-State: ACrzQf0E0zJolIBPzAhFqGtZLf2PgfEDtHXJOOnABInCVeyowKBL5rfy
        XQrLgEOoWw9m5vChjLmGOD4=
X-Google-Smtp-Source: AMsMyM59iKP1KjXRI2RY6VqzBoVOdD/CE027utRYZAkNz4qTSpNlYVSkeWNF/59ONOeFvkKGMfMkxw==
X-Received: by 2002:a05:6a00:138b:b0:561:966a:74a8 with SMTP id t11-20020a056a00138b00b00561966a74a8mr1403827pfg.5.1664794111171;
        Mon, 03 Oct 2022 03:48:31 -0700 (PDT)
Received: from jromail.nowhere (h219-110-108-104.catv02.itscom.jp. [219.110.108.104])
        by smtp.gmail.com with ESMTPSA id m3-20020a170902f64300b001781a7c28b9sm6850894plg.240.2022.10.03.03.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 03:48:30 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=jrobl) by jrobl id 1ofIzt-00020R-0Q ; Mon, 03 Oct 2022 19:48:29 +0900
From:   "J. R. Okajima" <hooanon05g@gmail.com>
Subject: Re: [PATCH][CFT] [coredump] don't use __kernel_write() on kmap_local_page()
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <YzpcXU2WO8e22Cmi@iweiny-desk3>
References: <YzN+ZYLjK6HI1P1C@ZenIV> <YzSSl1ItVlARDvG3@ZenIV> <YzpcXU2WO8e22Cmi@iweiny-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7713.1664794108.1@jrobl>
Date:   Mon, 03 Oct 2022 19:48:28 +0900
Message-ID: <7714.1664794108@jrobl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ira Weiny:
> On Wed, Sep 28, 2022 at 07:29:43PM +0100, Al Viro wrote:
> > On Tue, Sep 27, 2022 at 11:51:17PM +0100, Al Viro wrote:
> > > [I'm going to send a pull request tomorrow if nobody yells;
> > > please review and test - it seems to work fine here, but extra
> > > eyes and extra testing would be very welcome]

I tried gdb backtrace 'bt' command with the new core by v6.0, and it
doesn't show the call trace correctly. Is it related to this commit?

test program
----------------------------------------
void f(int n)
{
	printf("%d\n", n);
	if (!n)
		kill(getpid(), SIGQUIT);
	f(--n);
}

int main(int argc, char *argv[])
{
	f(atoi(argv[1]));
	return 0;
}
----------------------------------------
ulimit -c unlimited
coredump 2
gdb coredump core
bt
----------------------------------------
expected result
kill
f
f
f
main
----------------------------------------
actual result
??
??
----------------------------------------


J. R. Okajima
