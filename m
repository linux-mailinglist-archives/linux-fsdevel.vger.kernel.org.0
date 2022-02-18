Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFDE4BB03C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 04:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbiBRDaO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Feb 2022 22:30:14 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbiBRDaO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Feb 2022 22:30:14 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885ADC1C86;
        Thu, 17 Feb 2022 19:29:58 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKty0-002duL-HN; Fri, 18 Feb 2022 03:29:56 +0000
Date:   Fri, 18 Feb 2022 03:29:56 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Chris Mason <clm@fb.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Giuseppe Scrivano <gscrivan@redhat.com>
Subject: Re: [PATCH][RFC] ipc,fs: use rcu_work to free struct ipc_namespace
Message-ID: <Yg8StKzTWh+7FLuA@zeniv-ca.linux.org.uk>
References: <20220217153620.4607bc28@imladris.surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217153620.4607bc28@imladris.surriel.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 17, 2022 at 03:36:20PM -0500, Rik van Riel wrote:
> The patch works, but a cleanup question for Al Viro:
> 
> How do we get rid of #include "../fs/mount.h" and the raw ->mnt_ns = NULL thing
> in the cleanest way?

Hell knows...  mnt_make_shortterm(mnt) with big, fat warning along the lines of
"YOU MUST HAVE AN RCU GRACE PERIOD BEFORE YOU DROP THAT REFERENCE!!!", perhaps?
