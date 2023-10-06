Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C275D7BB7A3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 14:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjJFMac (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 08:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbjJFMa3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 08:30:29 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C75126;
        Fri,  6 Oct 2023 05:30:16 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:37482)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qojy7-00AOeg-9W; Fri, 06 Oct 2023 06:30:11 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:49692 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qojy5-001oHA-T0; Fri, 06 Oct 2023 06:30:10 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
        Deepak Gupta <debug@rivosinc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <aaea542c-929c-4c9b-8caa-ca67e0eb9c1e@sirena.org.uk>
        <ZOTnL1SDJWZjHPUW@arm.com>
        <43ec219d-bf20-47b8-a5f8-32bc3b64d487@sirena.org.uk>
        <ZOXa98SqwYPwxzNP@arm.com> <ZOYFazB1gYjzDRdA@arm.com>
        <ZRWw7aa3C0LlMPTH@arm.com>
        <38edb5c3-367e-4ab7-8cb7-aa1a5c0e330c@sirena.org.uk>
        <ZRvUxLgMse8QYlGS@arm.com>
        <a7d2fd66-c06b-4033-bca2-4b14afc4904f@sirena.org.uk>
        <ZR7w/mr0xZbpIPc5@arm.com>
        <638a7be5-6662-471d-a3ce-0de0ac768e99@sirena.org.uk>
Date:   Fri, 06 Oct 2023 07:29:45 -0500
In-Reply-To: <638a7be5-6662-471d-a3ce-0de0ac768e99@sirena.org.uk> (Mark
        Brown's message of "Fri, 6 Oct 2023 13:17:01 +0100")
Message-ID: <87y1ggylvq.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1qojy5-001oHA-T0;;;mid=<87y1ggylvq.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+LvOjycHAoB6LT49HjM3IrRBVDb8ivK8I=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Mark Brown <broonie@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 551 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 9 (1.6%), b_tie_ro: 8 (1.4%), parse: 1.11 (0.2%),
        extract_message_metadata: 3.3 (0.6%), get_uri_detail_list: 1.27 (0.2%),
         tests_pri_-2000: 3.5 (0.6%), tests_pri_-1000: 4.8 (0.9%),
        tests_pri_-950: 1.21 (0.2%), tests_pri_-900: 1.03 (0.2%),
        tests_pri_-200: 0.80 (0.1%), tests_pri_-100: 3.3 (0.6%),
        tests_pri_-90: 226 (41.0%), check_bayes: 222 (40.3%), b_tokenize: 10
        (1.8%), b_tok_get_all: 123 (22.2%), b_comp_prob: 3.0 (0.5%),
        b_tok_touch_all: 82 (14.9%), b_finish: 1.17 (0.2%), tests_pri_0: 271
        (49.3%), check_dkim_signature: 0.68 (0.1%), check_dkim_adsp: 3.1
        (0.6%), poll_dns_idle: 0.87 (0.2%), tests_pri_10: 4.3 (0.8%),
        tests_pri_500: 13 (2.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v4 03/36] arm64/gcs: Document the ABI for Guarded
 Control Stacks
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Mark Brown <broonie@kernel.org> writes:

> On Thu, Oct 05, 2023 at 06:23:10PM +0100, Catalin Marinas wrote:
>
>> It's not just the default size that I dislike (I think the x86
>> RLIMIT_STACK or clone3() stack_size is probably good enough) but the
>> kernel allocating the shadow stack and inserting it into the user
>> address space. The actual thread stack is managed by the user but the
>> shadow stack is not (and we don't do this very often). Anyway, I don't
>> have a better solution for direct uses of clone() or clone3(), other
>> than running those threads with the shadow stack disabled. Not sure
>> that's desirable.
>
> Running threads with the shadow stack disabled if they don't explicitly
> request it feels like it's asking for trouble - as well as the escape
> route from the protection it'd provide I'd expect there to be trouble
> for things that do stack pivots, potentially random issues if there's a
> mix of ways threads are started.  It's going to be a tradeoff whatever
> we do.

Something I haven't seen in the discussion is that one of the ways I
have seen a non-libc clone used is to implement a fork with flags.
That is a new mm is created, and effectively a new process.  Which
makes the characterization different.

In general creating a thread with clone and bypassing libc is
incompatible with pthreads, and the caller gets to keep both pieces.

As long as there is enough information code can detect that
shadow stacks are in use, and the code is able to create their own
I don't see why it shouldn't be the callers responsibility.

On the other hand I don't see the maintainer of clone Christian Brauner
or the libc folks especially Florian cc'd on this thread.  So I really
don't think you have the right folks in on this conversation.

Eric
k
