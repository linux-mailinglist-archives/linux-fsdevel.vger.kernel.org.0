Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF0543C8C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Oct 2021 13:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239831AbhJ0LpH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Oct 2021 07:45:07 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:44210 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239798AbhJ0LpG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Oct 2021 07:45:06 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 633E01FD3C;
        Wed, 27 Oct 2021 11:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1635334959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fo5sUfTsUY3UOkgJ2rkzuihsx0B4xmZU0SJdKHg3/K8=;
        b=BOue54GcW/uw1WPm5hiAmIdhozSdpxtIujuKNq+5lCqra257QQ5+yVC0mYQ5eawxHlKDyr
        nU0ifZU6580JYGww6p7MTa4j1eGWh/EpWynHxEW0BXP7jLQv8eUL4O/7yjEmIobBV3v+V+
        clwH2P5+gllvmD14GruEDwwE2lrVid8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1635334959;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fo5sUfTsUY3UOkgJ2rkzuihsx0B4xmZU0SJdKHg3/K8=;
        b=+LylReF1y8AGvSIYf9Izx8bkit9K4VmPNvnYXAU1IXcpJZ3PzIoU+CbwuMhJJKdrER1wb3
        YbEesObRpQJsk5Bg==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B48FCA3B84;
        Wed, 27 Oct 2021 11:42:38 +0000 (UTC)
Date:   Wed, 27 Oct 2021 13:42:38 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Ming Lei <ming.lei@redhat.com>
cc:     Petr Mladek <pmladek@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, tj@kernel.org,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        minchan@kernel.org, jeyu@kernel.org, shuah@kernel.org,
        bvanassche@acm.org, dan.j.williams@intel.com, joe@perches.com,
        tglx@linutronix.de, keescook@chromium.org, rostedt@goodmis.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: Re: [PATCH v8 11/12] zram: fix crashes with cpu hotplug multistate
In-Reply-To: <YXgguuAY5iEUIV0u@T590>
Message-ID: <alpine.LSU.2.21.2110271340180.3655@pobox.suse.cz>
References: <YWq3Z++uoJ/kcp+3@T590> <YW3LuzaPhW96jSBK@bombadil.infradead.org> <YW4uwep3BCe9Vxq8@T590> <alpine.LSU.2.21.2110190820590.15009@pobox.suse.cz> <YW6OptglA6UykZg/@T590> <alpine.LSU.2.21.2110200835490.26817@pobox.suse.cz> <YW/KEsfWJMIPnz76@T590>
 <alpine.LSU.2.21.2110201014400.26817@pobox.suse.cz> <YW/q70dLyF+YudyF@T590> <YXfA0jfazCPDTEBw@alley> <YXgguuAY5iEUIV0u@T590>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > 
> > The livepatch code uses workqueue because the livepatch can be
> > disabled via sysfs interface. It obviously could not wait until
> > the sysfs interface is removed in the sysfs write() callback
> > that triggered the removal.
> 
> If klp_free_patch_* is moved into module_exit() and not let enable
> store() to kill kobjects, all kobjects can be deleted in module_exit(),
> then wait_for_completion(patch->finish) may be removed, also wq isn't
> required for the async cleanup.

It sounds like a nice cleanup. If we combine kobject_del() to prevent any 
show()/store() accesses and free everything later in module_exit(), it 
could work. If I am not missing something around how we maintain internal 
lists of live patches and their modules.

Thanks

Miroslav
