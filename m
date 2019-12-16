Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E81BC121795
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2019 19:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730134AbfLPShI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 13:37:08 -0500
Received: from mga02.intel.com ([134.134.136.20]:6705 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730150AbfLPShI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:37:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 10:37:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,322,1571727600"; 
   d="scan'208";a="365105133"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga004.jf.intel.com with ESMTP; 16 Dec 2019 10:37:07 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id A37903003B3; Mon, 16 Dec 2019 10:37:07 -0800 (PST)
From:   Andi Kleen <ak@linux.intel.com>
To:     Dietmar Hahn <dietmar.hahn@ts.fujitsu.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] Fix a panic when core_pattern is set to "| prog..."
References: <2996767.y7E8ffpIOs@amur.mch.fsc.net>
Date:   Mon, 16 Dec 2019 10:37:07 -0800
In-Reply-To: <2996767.y7E8ffpIOs@amur.mch.fsc.net> (Dietmar Hahn's message of
        "Mon, 16 Dec 2019 14:48:07 +0100")
Message-ID: <87r214unfw.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dietmar Hahn <dietmar.hahn@ts.fujitsu.com> writes:

> Hi,
>
> if the /proc/sys/kernel/core_pattern is set with a space between '|' and the
> program and later a core file should be written the kernel panics.
> This happens because in format_corename() the first part of cn.corename
> is set to '\0' and later call_usermodehelper_exec() exits because of an
> empty command path but with return 0. But no pipe is created and thus
> cprm.file == NULL.
> This leads in file_start_write() to the panic because of dereferencing
> file_inode(file)->i_mode.

It would seem better to just skip the spaces and DTRT?

Of course doing the error check properly is a good idea anyways.

-Andi
