Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684D6244402
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Aug 2020 05:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgHND5M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 23:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgHND5M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 23:57:12 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7DFC061383
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 20:57:11 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id x69so7333711qkb.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 20:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tfz-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5MTuDeV+j3fzgYR5SGPLvxT4ilKSMnNxei9P2lIEnWw=;
        b=bu8dsCQKjF9Ov1Nw/qa5ydaYlZbu9Dh6UcAUBcJTG+6J6AyB2e+pghxSPQTGxvMXmN
         XgviDf2W8ZDKqcRpdH5TvHcp+8GApJWFRHcEQ6S7IJXUnssSYf2dR9SWehMkLbAT1wUQ
         9UZXldPpU5EV/UCSMyOkw2IToGLNbo7hbaUmnAOjUhKVZaQzXhCBaEnP5usyxGLZO5by
         wch6njTGkPo3xSmEXOPemOmVWFz8sOXB99nynjJ1Z29b6FQfh/hqjnx+xEh8eq48VoW9
         kgGwTdhfawQmH/3mx2OmEyZevcwsSLEiEhgZ4uTIh9S1L/l1mN6hbeOj2E4Nb68IKO7q
         LF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5MTuDeV+j3fzgYR5SGPLvxT4ilKSMnNxei9P2lIEnWw=;
        b=JWRjT6ubEMOas2ag4Mh50SCPN8eh6/prY4cRAE140k4DUd/faiOnCRsCnDPsopDciY
         CLgdT64TfIp99rV3BkOYA+oSjyIUElAwSIA/eaFmoYSuXAmUxJjkhGTQDk/AvIu6zLV+
         fCHlap1REbpa5ymNLJTjPIeD6hkSoD0U0fK1wwW1MZ4B5J1He7iZ3YwJjAXaoOn0J2T1
         xReMesB1BDTtrVyuxio8CnrTFGdgyE+NEqyBUNRwQEcBLr5j7o6wLH+ycrg1W5JUTGAT
         jHqHbFt+U/5yWZtVKGnsoth2fKZK76NjgfhTcYCZCap+1wIPb9jQXtOfgkiIOCBVyzAo
         zQIw==
X-Gm-Message-State: AOAM531+eBmagLSI3VZIw6zCHHOjjqavNQw5i7Js4xPBPWym4nSuCYUk
        AC/0ejct6kTjvaBDu44PNUEZOQ==
X-Google-Smtp-Source: ABdhPJwgDgLg7M2DAbRGUL+XBzE0jRtctTh0Je1JKmoNwZ7TJym5ipZUwDFbNJ2SYTiezA6zG1uDlA==
X-Received: by 2002:a37:5b41:: with SMTP id p62mr387011qkb.369.1597377431112;
        Thu, 13 Aug 2020 20:57:11 -0700 (PDT)
Received: from foo.attlocal.net (108-232-117-128.lightspeed.sntcca.sbcglobal.net. [108.232.117.128])
        by smtp.gmail.com with ESMTPSA id k11sm7229460qkk.93.2020.08.13.20.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 20:57:10 -0700 (PDT)
From:   Pascal Bouchareine <kalou@tfz.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Alexey Dobriyan" <adobriyan@gmail.com>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Jeff Layton" <jlayton@poochiereds.net>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "Pascal Bouchareine" <kalou@tfz.net>
Subject: [PATCH v4 0/2] proc,fcntl: introduce F_SET_DESCRIPTION
Date:   Thu, 13 Aug 2020 20:54:51 -0700
Message-Id: <20200814035453.210716-1-kalou@tfz.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a first attempt at taking Alexey's comments into account

This goes against v5.8

tl;dr in commit 2/2 but motivation is also described a bit in
https://lore.kernel.org/linux-api/CAGbU3_nVvuzMn2wo4_ZKufWcGfmGsopVujzTWw-Bbeky=xS+GA@mail.gmail.com/


