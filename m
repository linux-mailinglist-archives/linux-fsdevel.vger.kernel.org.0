Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D177105E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 09:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjEYHCL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 03:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjEYHCJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 03:02:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B297C1BF;
        Thu, 25 May 2023 00:02:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 406206192B;
        Thu, 25 May 2023 07:02:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC9EEC433EF;
        Thu, 25 May 2023 07:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684998126;
        bh=/zSCak2aKBEwS4L7xxLIATIg6Pb+0BRjbcVTt5j19I0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nmeUkigEx9ToiO75DmOjWBqyf3E23jOheRvmRlWmZ+aQ1Rb5oJqjUJNdiSguWKRZ+
         qqwVy5iRE95ZKwlAAqTA4kV+HMSMkqTTUekm2eKO5a6RuaoUwVj0p0W/TpJHv0Xjdn
         Sr0SXuk1b0u7NdgwlVhejgy2ypdDcXBNDDLluKr71TXP2vwImSwol7A7ng4SU3OKC0
         qE2nrRUd/oIcfTj5oSjn32oVFMqY24RnYVW+ov5aF//ppikCRjNoddfNyl3sPZ4M0d
         yOlV7Sx6CgEXqdW9lG/dL98Yt2wIHTR1iWjON2ndRseQch+uwr4+usFVaW6zy5I7HR
         MdrYnNKJXmVVQ==
Date:   Thu, 25 May 2023 09:01:55 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     david@redhat.com, tglx@linutronix.de, hch@lst.de,
        patches@lists.linux.dev, linux-modules@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com, lennart@poettering.net,
        gregkh@linuxfoundation.org, rafael@kernel.org, song@kernel.org,
        lucas.de.marchi@gmail.com, lucas.demarchi@intel.com,
        christophe.leroy@csgroup.eu, peterz@infradead.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, yujie.liu@intel.com,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 1/2] fs/kernel_read_file: add support for duplicate
 detection
Message-ID: <20230525-sporen-gesittet-b1cf61aa5dfa@brauner>
References: <20230524213620.3509138-1-mcgrof@kernel.org>
 <20230524213620.3509138-2-mcgrof@kernel.org>
 <CAHk-=wjahcAqLYm0ijcAVcPcQAz-UUuJ3Ubx4GzP_SJAupf=qQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wjahcAqLYm0ijcAVcPcQAz-UUuJ3Ubx4GzP_SJAupf=qQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 24, 2023 at 02:52:50PM -0700, Linus Torvalds wrote:
> On Wed, May 24, 2023 at 2:36 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > Add support for a new call which allows to detect duplicate requests
> > for each inode passed.
> 
> No.
> 
> This is all disgusting.
> 
> Stop adding horrific code for some made-up load that isn't real.

Also, this series adds non-trivial amount of code to fs/ without ever
having Cced fsdevel. As I told the bpf folks already if fs/ code is
touched fsdevel should absolutely be Cced, please.

It's literally also the first thing that get_maintainers.pl spews out.
