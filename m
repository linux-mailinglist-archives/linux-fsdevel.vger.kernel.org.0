Return-Path: <linux-fsdevel+bounces-29269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F239775F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 02:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57AAD1C24253
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 00:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605C9443D;
	Fri, 13 Sep 2024 00:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYhQzK4v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE1A1FBA;
	Fri, 13 Sep 2024 00:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726186725; cv=none; b=RioxzaFw9xKQDep7zUIqEGjs1b0NaXocF91acECdyU137o6j14zPygMJzQTTgRtoRnPbqKGZufa3plIxvRQnmukTmysuDQkuZHvBXJbpiV/ciriCrzDFiSN59S19YLndTauMIv/Xl2nR904OHQU0FbTeqdeA43re0e2rrS6E3tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726186725; c=relaxed/simple;
	bh=NJ0bm5aOPJS2BFRO+4CKYlGi6Px1qkw7j07yz/Q7nNw=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=J1elKc3J3OWXiIF9REOonACEQAawBDEg6wjS4kCwchekExgM38VIQ4T11ZANIfydHpt4mTnKRJ2VCeHDEUU6W5Lw/WW3uyzNFlC/FPc6dspsqhvUx0qY40cQH8gwnccRNx83oVa7i11Cusb4E1iF7KsyNwGaVl7dXcKyhgu85pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qYhQzK4v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0FBAC4CEC3;
	Fri, 13 Sep 2024 00:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726186725;
	bh=NJ0bm5aOPJS2BFRO+4CKYlGi6Px1qkw7j07yz/Q7nNw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=qYhQzK4vF5/1OZU5KHGENzVChr6ge9H+jyFeIonuLbCp8gxnh2HoR4tMH6r9ySzT7
	 M90Uhd8nTZ9aGVlBS62SqC5dZBQOL1yZOBRs3zh23Y9lAmLGNaVzSxYrqN2kgoe8cw
	 Ud6wStVcNaGm6CxgtXNKQYOdBVB/r1cq2ggWy3nUnOT6LpmvdQxG7SAtno0acaPTmN
	 1qA7Hen4EBBK4SbqkjvonzxNKxiWJF0KX42pSWE4g9jn0dk+ID+QgWiLC1LLgDlePB
	 uhUr6TXCueydWaJ5SDC2N1+/loraiKIro9HOPqznE9ROU0reAHki5gooOrEr4wE8LS
	 3tzx18yEbGhAA==
Date: Thu, 12 Sep 2024 19:18:43 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Deepak Gupta <debug@rivosinc.com>
Cc: andrii@kernel.org, peterz@infradead.org, guoren@kernel.org, 
 sunilvl@ventanamicro.com, paul.walmsley@sifive.com, 
 ben.dooks@codethink.co.uk, broonie@kernel.org, david@redhat.com, 
 vbabka@suse.cz, schwab@suse.de, alexghiti@rivosinc.com, bp@alien8.de, 
 palmer@sifive.com, leobras@redhat.com, jerry.shih@sifive.com, 
 palmer@dabbelt.com, oleg@redhat.com, sameo@rivosinc.com, alx@kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 songshuaishuai@tinylab.org, x86@kernel.org, linux-fsdevel@vger.kernel.org, 
 zong.li@sifive.com, tglx@linutronix.de, samuel.holland@sifive.com, 
 evan@rivosinc.com, hpa@zytor.com, linux-mm@kvack.org, bgray@linux.ibm.com, 
 zev@bewilderbeest.net, linux-riscv@lists.infradead.org, namcaov@gmail.com, 
 bjorn@rivosinc.com, ebiederm@xmission.com, xiao.w.wang@intel.com, 
 rppt@kernel.org, samitolvanen@google.com, devicetree@vger.kernel.org, 
 aou@eecs.berkeley.edu, tanzhasanwork@gmail.com, sorear@fastmail.com, 
 linux-kselftest@vger.kernel.org, anup@brainfault.org, corbet@lwn.net, 
 conor@kernel.org, kees@kernel.org, dawei.li@shingroup.cn, 
 dave.hansen@linux.intel.com, deller@gmx.de, jszhang@kernel.org, 
 ke.zhao@shingroup.cn, Liam.Howlett@oracle.com, puranjay@kernel.org, 
 cleger@rivosinc.com, ancientmodern4@gmail.com, willy@infradead.org, 
 libang.li@antgroup.com, yang.lee@linux.alibaba.com, 
 quic_bjorande@quicinc.com, usama.anjum@collabora.com, costa.shul@redhat.com, 
 andy.chiu@sifive.com, ryan.roberts@arm.com, revest@chromium.org, 
 mchitale@ventanamicro.com, cuiyunhui@bytedance.com, arnd@arndb.de, 
 brauner@kernel.org, antonb@tenstorrent.com, lorenzo.stoakes@oracle.com, 
 shuah@kernel.org, mingo@redhat.com, catalin.marinas@arm.com, 
 osalvador@suse.de, greentime.hu@sifive.com, linux-arch@vger.kernel.org, 
 krzk+dt@kernel.org, bhe@redhat.com, ajones@ventanamicro.com, 
 quic_zhonhan@quicinc.com, akpm@linux-foundation.org, charlie@rivosinc.com, 
 atishp@rivosinc.com
In-Reply-To: <20240912231650.3740732-8-debug@rivosinc.com>
References: <20240912231650.3740732-1-debug@rivosinc.com>
 <20240912231650.3740732-8-debug@rivosinc.com>
Message-Id: <172618672393.1080888.11349502657556279668.robh@kernel.org>
Subject: Re: [PATCH v4 07/30] riscv: zicfilp / zicfiss in dt-bindings
 (extensions.yaml)


On Thu, 12 Sep 2024 16:16:26 -0700, Deepak Gupta wrote:
> Make an entry for cfi extensions in extensions.yaml.
> 
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  .../devicetree/bindings/riscv/extensions.yaml        | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/riscv/extensions.yaml:367:75: [error] missing starting space in comment (comments)
./Documentation/devicetree/bindings/riscv/extensions.yaml:368:13: [error] syntax error: expected <block end>, but found '<scalar>' (syntax)
./Documentation/devicetree/bindings/riscv/extensions.yaml:373:75: [error] missing starting space in comment (comments)
./Documentation/devicetree/bindings/riscv/extensions.yaml:374:13: [warning] wrong indentation: expected 10 but found 12 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/riscv/extensions.yaml: ignoring, error parsing file
make[2]: *** Deleting file 'Documentation/devicetree/bindings/riscv/extensions.example.dts'
Documentation/devicetree/bindings/riscv/extensions.yaml:368:13: did not find expected key
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/riscv/extensions.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/riscv/cpus.example.dtb: cpu@0: False schema does not allow {'clock-frequency': 0, 'compatible': ['sifive,rocket0', 'riscv'], 'device_type': ['cpu'], 'i-cache-block-size': 64, 'i-cache-sets': 128, 'i-cache-size': 16384, 'reg': [[0]], 'riscv,isa-base': ['rv64i'], 'riscv,isa-extensions': [1761635584, 1627415296], 'interrupt-controller': {'#interrupt-cells': 1, 'compatible': ['riscv,cpu-intc'], 'interrupt-controller': True}, '$nodename': ['cpu@0']}
	from schema $id: http://devicetree.org/schemas/riscv/cpus.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/riscv/cpus.example.dtb: cpu@0: Unevaluated properties are not allowed ('riscv,isa-base', 'riscv,isa-extensions' were unexpected)
	from schema $id: http://devicetree.org/schemas/riscv/cpus.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/riscv/cpus.example.dtb: cpu@1: False schema does not allow {'clock-frequency': 0, 'compatible': ['sifive,rocket0', 'riscv'], 'd-cache-block-size': 64, 'd-cache-sets': 64, 'd-cache-size': 32768, 'd-tlb-sets': 1, 'd-tlb-size': 32, 'device_type': ['cpu'], 'i-cache-block-size': 64, 'i-cache-sets': 64, 'i-cache-size': 32768, 'i-tlb-sets': 1, 'i-tlb-size': 32, 'mmu-type': ['riscv,sv39'], 'reg': [[1]], 'tlb-split': True, 'riscv,isa-base': ['rv64i'], 'riscv,isa-extensions': [1761635584, 1627416064, 1677746944], 'interrupt-controller': {'#interrupt-cells': 1, 'compatible': ['riscv,cpu-intc'], 'interrupt-controller': True}, '$nodename': ['cpu@1']}
	from schema $id: http://devicetree.org/schemas/riscv/cpus.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/riscv/cpus.example.dtb: cpu@1: Unevaluated properties are not allowed ('riscv,isa-base', 'riscv,isa-extensions' were unexpected)
	from schema $id: http://devicetree.org/schemas/riscv/cpus.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/riscv/cpus.example.dtb: cpu@0: False schema does not allow {'device_type': ['cpu'], 'reg': [[0]], 'compatible': ['riscv'], 'mmu-type': ['riscv,sv48'], 'riscv,isa-base': ['rv64i'], 'riscv,isa-extensions': [1761635584, 1627416064, 1677746944], 'interrupt-controller': {'#interrupt-cells': 1, 'interrupt-controller': True, 'compatible': ['riscv,cpu-intc']}, '$nodename': ['cpu@0']}
	from schema $id: http://devicetree.org/schemas/riscv/cpus.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/riscv/cpus.example.dtb: cpu@0: Unevaluated properties are not allowed ('riscv,isa-base', 'riscv,isa-extensions' were unexpected)
	from schema $id: http://devicetree.org/schemas/riscv/cpus.yaml#
./Documentation/devicetree/bindings/riscv/extensions.yaml:368:13: did not find expected key
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1432: dt_binding_check] Error 2
make: *** [Makefile:224: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240912231650.3740732-8-debug@rivosinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


