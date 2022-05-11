Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FF8523D97
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 21:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346992AbiEKTdX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 15:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346991AbiEKTdQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 15:33:16 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF8216ABE2;
        Wed, 11 May 2022 12:33:15 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id w19so5274719lfu.11;
        Wed, 11 May 2022 12:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=XXF6OYI3qB5yttavT8X42EHp+sKvbnUf1JIGgX6NgFY=;
        b=nxwpZRXVnOwm4rI3doQVxeE/xUeSHswRsyAoCuN6or15H3sbP7P+moh3izUYSh8q0o
         vKhwd8GQwUoAQ9X7ZfT/GKK4Ce/Eb8A8spYo8cvOTh4dsuAFtuO2JJF0O5jzUnF646/2
         PdKpNTBqNcOrAI6XNrK7WjixloC96hyYbbYZXo+nL94dfvKU7ps8OJdLG0mZFRHudjaW
         rZYfWnJ8bOrciigZxEZxotB04VlspQFDto9Z/HWT9xNgAihFKe5+m9YEtsroP+i7hVGa
         n6PNeM4bs/4QmkHzeJyar2i1jfbWWJhrLTpe+mB9tIFDVbpAbLufvrgpy90bpZfCN4Zk
         QvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=XXF6OYI3qB5yttavT8X42EHp+sKvbnUf1JIGgX6NgFY=;
        b=CsyqFZ7UzPrWGdSI4e7CftQr3dYKSoe4zoNwQmWJcFi05NUA+vEdzE2j11g031LItq
         U5RgMtpH+RouPos70vEF07aFANsRXP/KvoF2fwXpVdLx2I9PlpPsWsO+OJUOVytgUaS5
         IFhLDJXOb2DZuWSiHFecig2Ul+YNYw5SBksnsJvMsHas0WEbDNjxchRZPEuMTL/FUBFc
         S/Fv7rYxZ4RK06TfWlW0D2tWZHVQKfl+lfWHAEURDNE2mUf5L4oC+0AnH9PFAAlJ49WF
         f3Suh4jgG8lGqHOzDIQ6GpVk8gtCBT/q4l+HJnvcxtM2FDuONHyHZJHzyQYhfz2Ej0lu
         +xJQ==
X-Gm-Message-State: AOAM531k9AHfzmDaF39oAf1wj54BV0fv0TiCUVobbPG8JQJjhwUr9Zvq
        +qWxWd0g4RJ7O5LsT0WRE0kcdfl2giJ8H+wctCZjA6nC
X-Google-Smtp-Source: ABdhPJweqdnMSyi9XqObW6kKsNdHrxKx+zPWGJJv17tn1WEi+m85s2En6OuemBGJA8Qpn54NlXDPyXsjnpcipz1rmFA=
X-Received: by 2002:a19:ca0f:0:b0:474:40ca:af2 with SMTP id
 a15-20020a19ca0f000000b0047440ca0af2mr4076979lfg.320.1652297593133; Wed, 11
 May 2022 12:33:13 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 11 May 2022 14:33:01 -0500
Message-ID: <CAH2r5mvoQskGmY5SkgktzS1ZALeq7uk29EpLELLjVwcwYRwT1g@mail.gmail.com>
Subject: misreported st_blocks (AllocationSize)
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     samba-technical <samba-technical@lists.samba.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Was investigating trying to fix emulation of some fallocate flags, and
was wondering how common is it for a fs to very loosely report
allocation size (st_blocks) for a file - ie the allocation sizes does
not match the allocate ranges returned by fiemap (or
SEEK_HOLE/SEEK_DATA).   Presumably there are Linux fs that coalesce
ranges on the fly so allocation sizes may be a 'guess' for some fs.

How common is this for it to be off?

-- 
Thanks,

Steve
