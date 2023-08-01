Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D02A76B6FC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 16:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbjHAONl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 10:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234468AbjHAONe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:13:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2958C269F;
        Tue,  1 Aug 2023 07:13:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4E9D615C9;
        Tue,  1 Aug 2023 14:13:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C215FC433C7;
        Tue,  1 Aug 2023 14:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690899209;
        bh=NTBwd29Dbu+ECP276LsKiM8HBDKaR00BKAB6CRCf3bE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=abqS+G0uERa7fIKrH4hSw9IDBy+zR3n2e2RncQqAqkzlG6NQHu8J5iIFlkwrB657I
         oJQ0+vDyHimf0Zzmz13ZMAyco3wCnDXoFSci37voDkjQr4SVseAsIyVJ06v3CG1ZKX
         wA4zk4L/vjGB4EVHMfxhGACjxWZzRWGs+AESTu3SAB7pEpFPTu5QyCSKsYrmv6ocyz
         STvBOLI5/v9lmw1IkmkGMiZootxRVm5BrSrS3Z8ppbrLm97hcIZG9bJiqDSG26raqx
         VegkDKaNPneU+4IvGTtTT2RITGdJC90YBsdQ0YM0USvoHqq9xrcZJCf7t4mwUrCzhT
         F9wsepVvvxiMA==
Date:   Tue, 1 Aug 2023 15:13:20 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
        Deepak Gupta <debug@rivosinc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 00/36] arm64/gcs: Provide support for GCS in userspace
Message-ID: <20230801141319.GC26253@willie-the-truck>
References: <20230731-arm64-gcs-v3-0-cddf9f980d98@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731-arm64-gcs-v3-0-cddf9f980d98@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 31, 2023 at 02:43:09PM +0100, Mark Brown wrote:
> The arm64 Guarded Control Stack (GCS) feature provides support for
> hardware protected stacks of return addresses, intended to provide
> hardening against return oriented programming (ROP) attacks and to make
> it easier to gather call stacks for applications such as profiling.

Why is this better than Clang's software shadow stack implementation? It
would be nice to see some justification behind adding all this, rather
than it being an architectural tick-box exercise.

Will
