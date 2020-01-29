Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60AE614C563
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 05:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgA2Ewc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jan 2020 23:52:32 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57150 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgA2Ewc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jan 2020 23:52:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=avy9Fk+Wu+NJ94LNqZYBATBErrgaEc+SgcZanTZL+Rs=; b=dIGAw0i+1CpXM2BqH2c4Thj7b
        G8cL7MShJeRXwRyPprM+2iBeC+CSB3cz97AQTksPha5YOErUWdujv1cYFz2C3ua73imUeIYcuaiPx
        N9TPRedtu6nztuBEjtWYnbrEZuC74IQpI2m9hc9mjPw/jgPrUBOXG8ObgaP0/yi6tvN25OhiH6+Zi
        yUGrMUOqLD1VgXFICy/mZuVkOt1jPZUYuUQtPPPm+navZDqVnRkHzh7IPtcrLikHPWYsocl2BaC8g
        weRrmQ5Ghr81IvTTNQtY2n9smYTpsLZ2tvJROO4uVLM1OomLV5rhcb86uJ6Ruz7v13F73QeQmqHML
        QLQQSN/HA==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwfL3-0004uW-Up; Wed, 29 Jan 2020 04:52:30 +0000
Subject: Re: mmotm 2020-01-28-20-05 uploaded (security/security.c)
To:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        linux-security-module <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
References: <20200129040640.6PNuz0vcp%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <56177bc4-441d-36f4-fe73-4e86edf02899@infradead.org>
Date:   Tue, 28 Jan 2020 20:52:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200129040640.6PNuz0vcp%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/28/20 8:06 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2020-01-28-20-05 has been uploaded to
> 
>    http://www.ozlabs.org/~akpm/mmotm/
> 
> mmotm-readme.txt says
> 
> README for mm-of-the-moment:
> 
> http://www.ozlabs.org/~akpm/mmotm/
> 
> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> more than once a week.
> 

security/security.c contains duplicate lines for <lockdown_reasons> array:

/*
 * These are descriptions of the reasons that can be passed to the
 * security_locked_down() LSM hook. Placing this array here allows
 * all security modules to use the same descriptions for auditing
 * purposes.
 */
const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
	[LOCKDOWN_NONE] = "none",
	[LOCKDOWN_MODULE_SIGNATURE] = "unsigned module loading",
	[LOCKDOWN_DEV_MEM] = "/dev/mem,kmem,port",
	[LOCKDOWN_EFI_TEST] = "/dev/efi_test access",
	[LOCKDOWN_KEXEC] = "kexec of unsigned images",
	[LOCKDOWN_HIBERNATION] = "hibernation",
	[LOCKDOWN_PCI_ACCESS] = "direct PCI access",
	[LOCKDOWN_IOPORT] = "raw io port access",
	[LOCKDOWN_MSR] = "raw MSR access",
	[LOCKDOWN_ACPI_TABLES] = "modifying ACPI tables",
	[LOCKDOWN_PCMCIA_CIS] = "direct PCMCIA CIS storage",
	[LOCKDOWN_TIOCSSERIAL] = "reconfiguration of serial port IO",
	[LOCKDOWN_MODULE_PARAMETERS] = "unsafe module parameters",
	[LOCKDOWN_MMIOTRACE] = "unsafe mmio",
	[LOCKDOWN_DEBUGFS] = "debugfs access",
	[LOCKDOWN_XMON_WR] = "xmon write access",
	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
	[LOCKDOWN_KCORE] = "/proc/kcore access",
	[LOCKDOWN_KPROBES] = "use of kprobes",
	[LOCKDOWN_BPF_READ] = "use of bpf to read kernel RAM",
	[LOCKDOWN_PERF] = "unsafe use of perf",
	[LOCKDOWN_TRACEFS] = "use of tracefs",
	[LOCKDOWN_XMON_RW] = "xmon read and write access",
	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
};

/*
 * These are descriptions of the reasons that can be passed to the
 * security_locked_down() LSM hook. Placing this array here allows
 * all security modules to use the same descriptions for auditing
 * purposes.
 */
const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
	[LOCKDOWN_NONE] = "none",
	[LOCKDOWN_MODULE_SIGNATURE] = "unsigned module loading",
	[LOCKDOWN_DEV_MEM] = "/dev/mem,kmem,port",
	[LOCKDOWN_EFI_TEST] = "/dev/efi_test access",
	[LOCKDOWN_KEXEC] = "kexec of unsigned images",
	[LOCKDOWN_HIBERNATION] = "hibernation",
	[LOCKDOWN_PCI_ACCESS] = "direct PCI access",
	[LOCKDOWN_IOPORT] = "raw io port access",
	[LOCKDOWN_MSR] = "raw MSR access",
	[LOCKDOWN_ACPI_TABLES] = "modifying ACPI tables",
	[LOCKDOWN_PCMCIA_CIS] = "direct PCMCIA CIS storage",
	[LOCKDOWN_TIOCSSERIAL] = "reconfiguration of serial port IO",
	[LOCKDOWN_MODULE_PARAMETERS] = "unsafe module parameters",
	[LOCKDOWN_MMIOTRACE] = "unsafe mmio",
	[LOCKDOWN_DEBUGFS] = "debugfs access",
	[LOCKDOWN_XMON_WR] = "xmon write access",
	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
	[LOCKDOWN_KCORE] = "/proc/kcore access",
	[LOCKDOWN_KPROBES] = "use of kprobes",
	[LOCKDOWN_BPF_READ] = "use of bpf to read kernel RAM",
	[LOCKDOWN_PERF] = "unsafe use of perf",
	[LOCKDOWN_TRACEFS] = "use of tracefs",
	[LOCKDOWN_XMON_RW] = "xmon read and write access",
	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
};



Stephen, you might delete half of those for linux-next....

-- 
~Randy

