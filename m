Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6674E7DFA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Mar 2022 01:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbiCYV1S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Mar 2022 17:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbiCYV1Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Mar 2022 17:27:16 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA80B23C0EC
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Mar 2022 14:25:41 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id B6D2E1F467F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648243540;
        bh=HXeqRMeQE7R6n2ndddhQlyV94EIUHcEA4j5aKNJbKiA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=cgNbsUIx6OwXBs3omsY+8iI3cXeFj+zeqJTXDTFwHW0tnjbtszuac7SMLYrWaKxCW
         ih3/uhsZHWLADspwx7Xc+Lf7LgAwje2BR53RIu+Y6OEmzIx9VD3juJcLzUOzCHa9Th
         xNzFoHdrBl3cL37xgSWlIFt+6BNntMXwm2oyXyYHAji4kDKC+WfWbwYhg5Jdi9CtSh
         CXhjvu+rRtXa4hp+F9PgV7c0yLZBgaHlwynFagIHJz3UDZZj9Cpg6o+00PtnDpWwVq
         nKUWkrM/74z0swALxf0xlsG/U2A84ZwC9UxfmGl+rTXH9nafIIXoVXyXKqBeqLcom4
         clmdyI72L99tQ==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jianchunfu <jianchunfu@cmss.chinamobile.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] fs:unicode:mkutf8data.c: Fix the potential stack overflow
 risk
Organization: Collabora
References: <20220325091443.59677-1-jianchunfu@cmss.chinamobile.com>
Date:   Fri, 25 Mar 2022 17:25:35 -0400
In-Reply-To: <20220325091443.59677-1-jianchunfu@cmss.chinamobile.com>
        (jianchunfu@cmss.chinamobile.com's message of "Fri, 25 Mar 2022
        17:14:43 +0800")
Message-ID: <87o81tpvw0.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

jianchunfu <jianchunfu@cmss.chinamobile.com> writes:

> I'm not sure why there are so many missing checks of the malloc function,
> is it because the memory allocated is only a few bytes
> so no checks are needed?
>
> Signed-off-by: jianchunfu <jianchunfu@cmss.chinamobile.com>

Hi jianchunfu,

Thanks for the patch.

Beyond what Eric said, the patch prefix should be just "unicode:".  When
in doubt you can see the previous patches to the subsystem in the git
log.  Also, I think these are not really  stack overflows, but a bad
memory access if malloc fails.  What do you think of something like

unicode: Handle memory allocation failures in mkutf8data

or something like that.

Thanks,

-- 
Gabriel Krisman Bertazi
