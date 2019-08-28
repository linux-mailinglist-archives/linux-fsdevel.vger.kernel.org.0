Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27F9FA0534
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2019 16:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfH1OlB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Aug 2019 10:41:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:53714 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726428AbfH1OlB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Aug 2019 10:41:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D959CADFE;
        Wed, 28 Aug 2019 14:40:59 +0000 (UTC)
Date:   Wed, 28 Aug 2019 16:40:58 +0200
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        David Hildenbrand <david@redhat.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Breno Leitao <leitao@debian.org>,
        Michael Neuling <mikey@neuling.org>,
        Firoz Khan <firoz.khan@linaro.org>,
        Allison Randal <allison@lohutok.net>,
        Joel Stanley <joel@jms.id.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 0/4] Disable compat cruft on ppc64le v2
Message-ID: <20190828164058.76a395b8@naga>
In-Reply-To: <1566988993.aiyajovdx0.astroid@bobo.none>
References: <cover.1566987936.git.msuchanek@suse.de>
        <1566988993.aiyajovdx0.astroid@bobo.none>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 28 Aug 2019 20:57:48 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> Michal Suchanek's on August 28, 2019 8:30 pm:
> > With endian switch disabled by default the ppc64le compat supports
> > ppc32le only which is something next to nobody has binaries for.
> > 
> > Less code means less bugs so drop the compat stuff.  
> 
> Interesting patches, thanks for looking into it. I don't know much
> about compat and wrong endian userspaces. I think sys_switch_endian
> is enabled though, it's just a strange fast endian swap thing that
> has been disabled by default.
> 
> The first patches look pretty good. Maybe for the last one it could
> become a selectable option?

That sounds good.

> 
> 
> > I am not particularly sure about the best way to resolve the llseek
> > situation. I don't see anything in the syscal tables making it
> > 32bit-only so I suppose it should be available on 64bit as well.  
> 
> It's for 32-bit userspace only. Can we just get rid of it, or is
> there some old broken 64-bit BE userspace that tries to call it?

That sounds like a bug in creating these unified syscall tables then.
On architectures that have split tables the 64bit ones do not have
llseek. On architectures with one table the syscall is marked as common.

Thanks

Michal
