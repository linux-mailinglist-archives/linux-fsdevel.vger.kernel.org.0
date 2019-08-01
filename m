Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA2987DFC4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 18:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731876AbfHAQJO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Aug 2019 12:09:14 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:55530 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfHAQJN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Aug 2019 12:09:13 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1htDde-0003to-U2; Thu, 01 Aug 2019 16:09:11 +0000
Date:   Thu, 1 Aug 2019 17:09:10 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] selinux: fix race when removing selinuxfs entries
Message-ID: <20190801160910.GW1131@ZenIV.linux.org.uk>
References: <20190801140243.24080-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801140243.24080-1-omosnace@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 01, 2019 at 04:02:39PM +0200, Ondrej Mosnacek wrote:
> After hours and hours of getting familiar with dcache and debugging,
> I think I finally found a solution that works and hopefully stands a
> chance of being committed.
> 
> The series still doesn't address the lack of atomicity of the policy
> reload transition, but this is part of a wider problem and can be
> resolved later. Let's fix at least the userspace-triggered lockup
> first.

I don't think this is the right approach.  Consider the related problem:
what happens if somebody has mounted something upon a selinuxfs file?
That is the hard part here, and AFAICS your variant doesn't help it
at all...
