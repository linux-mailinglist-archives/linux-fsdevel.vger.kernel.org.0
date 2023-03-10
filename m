Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1226B52C6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 22:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbjCJVZ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 16:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbjCJVZq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 16:25:46 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5066D1F93D;
        Fri, 10 Mar 2023 13:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=03OK38+luaFApHRGtLqj5LGDP9Ss1QBIdH6PfL12cGs=; b=URGriHIQAtQLUbmvB3NuU7lsoX
        y2Vky/iX2gR/aN3WlDnD1C32FHLOYCDd3WZdD7EkqDOz7tLMdhi0azGtctcx28iy4KMM2oglkiwkn
        eSW8SALrql//WJAV14UrnZ9gIBiLm2qEWUP/x0t3lPC+Z199LYYDLRxNB8DpHpAVDYizeqdbclKS6
        AOHtdtvwgK6NpQEJ08wIES7AuDO8qZ8t0O558IuHubGMy1Uu0G056J7QFIBQmqrLT1e8C9GA0Jd1Q
        hu5BJtB5ERd6jnsmwcZc1s0h4VIJh/AdX8NoZFHk+GgQPa2CrszbuHVCyAfLTT35vwHJhFsqNfRvB
        SqQvD+fA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pakF6-00FR2F-2f;
        Fri, 10 Mar 2023 21:25:36 +0000
Date:   Fri, 10 Mar 2023 21:25:36 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCHES] fget()-to-fdget() whack-a-mole
Message-ID: <20230310212536.GX3390869@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	fget()/fget_raw() should be used when we are going to keep
struct file reference; for temporary references fdget()/fdget_raw()
ought to be used.  That kind of stuff keeps cropping up on a regular
basis, and it needs periodic pruning.

	The current pile is in vfs.git #work.fd; individual patches
in followups.
